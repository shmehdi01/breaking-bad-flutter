import 'package:breakingbad/app/ui/base/bloc_builder.dart';
import 'package:breakingbad/app/ui/base/bloc_provider.dart';
import 'package:breakingbad/app/ui/characters/detail/character_detail_screen.dart';
import 'package:breakingbad/app/ui/characters/models/character.dart';
import 'package:breakingbad/app/ui/widgets/error_page.dart';
import 'package:breakingbad/app/utils/mixin_navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap_widget/gap_widget.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatefulWidget with AppNavigator {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  late BuildContext _innerContext;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final bloc = BlocProvider.of(_innerContext).bloc as HomeBloc;
        if (bloc.currentState is CharacterList) {
          final oldState = bloc.currentState as CharacterList;
          bloc.dispatchEvent(LoadCharacters(
              oldData: oldState.data,
              page: oldState.currentPage + 1,
              isPagination: true));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: HomeBloc()..dispatchEvent(LoadCharacters()),
      builder: (BuildContext innerContext) {
        _innerContext = innerContext;
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: StreamBuilder<bool>(
                  stream: (BlocProvider.of(innerContext).bloc as HomeBloc)
                      .isShowSearch,
                  builder: (_, snapshot) {
                    if (snapshot.data == true) {
                      return SearchAppBar();
                    }

                    return AppBar(
                      title: const Text("Breaking Bad Characters"),
                      actions: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of(innerContext)
                                  .bloc
                                  .dispatchEvent(SearchViewEvent(show: true));
                            },
                            icon: const Icon(Icons.search)),
                      ],
                    );
                  })),
          body:
              SafeArea(child: BlocBuilder<HomeState>(builder: (context, state) {

            if (state is HomeLoading) {
               return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeError) {
              return ErrorScreen(
                errorTitle: 'Something went wrong',
                errorMessage: state.message,
              );
            }

            if (state is HomeNoData) {
              return ErrorScreen(
                errorTitle: 'Opps',
                errorMessage: state.message,
              );
            }
            final CharacterList characterList = state as CharacterList;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: characterList.data.length,
                        itemBuilder: (_, index) {
                          final data = characterList.data[index];
                          return CharacterTile(data: data);
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      ),
                    ),
                  Visibility(
                      visible: state.isPaginationLoading, //state is HomeLoading,
                      child: const CircularProgressIndicator())
                ],
              ),
            );
          })),
        );
      },
    );
  }

  @override
  void dispose() {
    BlocProvider.of(_innerContext).bloc.dispose();
    super.dispose();
  }
}

class SearchAppBar extends StatelessWidget {
  SearchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          IconButton(
              onPressed: () {
                BlocProvider.of(context).bloc.dispatchEvent(SearchViewEvent(
                      show: false,
                    ));
                BlocProvider.of(context).bloc.dispatchEvent(LoadCharacters());
              },
              icon: const Icon(Icons.arrow_back_outlined)),
          Expanded(
            child: TextField(
                //controller: _searchEditController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white30),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
                onChanged: (query) {
                  if (query.isEmpty) {
                    BlocProvider.of(context)
                        .bloc
                        .dispatchEvent(LoadCharacters());
                    return;
                  }
                  BlocProvider.of(context)
                      .bloc
                      .dispatchEvent(HomeSearchEvent(query));
                }),
          ),
        ],
      ),
    );
  }
}

class CharacterTile extends StatelessWidget with AppNavigator {
  const CharacterTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Character data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          navigate(
              CharacterDetailScreen(characterId: data.id, title: data.name));
        },
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: CachedNetworkImageProvider(data.img),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  VerticalGap(),
                  const Text(
                    "Birthday",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  ),
                  VerticalGap(),
                  Text(
                    data.birthday,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
