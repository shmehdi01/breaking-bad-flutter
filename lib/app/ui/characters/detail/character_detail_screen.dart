import 'package:breakingbad/app/ui/base/bloc_builder.dart';
import 'package:breakingbad/app/ui/base/bloc_provider.dart';
import 'package:breakingbad/app/ui/characters/detail/bloc/character_detail_bloc.dart';
import 'package:breakingbad/app/ui/characters/detail/bloc/character_detail_event.dart';
import 'package:breakingbad/app/ui/characters/detail/bloc/character_detail_state.dart';
import 'package:breakingbad/app/ui/characters/models/character.dart';
import 'package:breakingbad/app/ui/widgets/error_page.dart';
import 'package:breakingbad/resource/color_palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap_widget/gap_widget.dart';

class CharacterDetailScreen extends StatelessWidget {
  final int characterId;
  final String? title;

  const CharacterDetailScreen({Key? key, required this.characterId, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: CharacterDetailBloc()..dispatchEvent(LoadCharacter(characterId)),
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: kColorWhite,
            appBar: AppBar(
              title: Text(title ?? ""),
            ),
            body: BlocBuilder<CharacterDetailState>(
              builder: (context, state) {
                if (state is LoadingDetailCharacter) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CharacterDetailError) {
                  return ErrorScreen(
                      errorTitle: "Something went wrong",
                      errorMessage: state.message);
                }

                if (state is CharacterNotFound) {
                  return const ErrorScreen(
                      errorTitle: "Opps,", errorMessage: "Character not found");
                }

                if (state is CharacterData) {
                  return CharacterInfo(character: state.data);
                }
                return Container();
              },
            ));
      },
    );
  }
}

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image(image: CachedNetworkImageProvider(character.img), fit: BoxFit.fill,),
          ),
        ),
        VerticalGap.v20,
        Card(
          child: Column(
            children: [
              const HeaderText(text: "Character Information",),
              VerticalGap(),
              InfoTile(title: "Full Name", text: character.name),
              VerticalGap(),
              InfoTile(title: "Nickname", text: character.nickname),
              VerticalGap(),
              InfoTile(title: "Date of birth", text: character.birthday), //Can be formatted but not doing
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              const HeaderText(text: "Other Info",),
              VerticalGap(),
              InfoTile(title: "Occupation", text: character.occupation.join(", ")),
              VerticalGap(),
              InfoTile(title: "Session", text: character.appearance.join(", ").toString()),
              VerticalGap(),
              InfoTile(title: "Portrayed", text: character.portrayed), //Can be formatted but not doing
            ],
          ),
        ),
        VerticalGap(),
        Column(
          children: [
            const HeaderText(text: "STATUS",),
            VerticalGap(),
            Text(character.status, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
          ],
        ),
      ],),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key, required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child:  Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kColorWhite),));
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({Key? key, required this.title,required this.text}) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(child: Text(title.toUpperCase(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kColorBlack),), flex: 1,),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: kColorBlack),), flex: 2,),
        ],
      ),
    );
  }
}

