import 'dart:async';

import 'package:breakingbad/app/data/repositories/character_repository.dart';
import 'package:breakingbad/app/ui/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final repository = CharacterRepository();

  final _isShowSearch = BehaviorSubject<bool>();
  HomeState currentState = Idle();

  Stream<bool> get isShowSearch => _isShowSearch.stream;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SearchViewEvent) {
      _isShowSearch.add(event.show);
    }

    if (event is LoadCharacters) {
      if (!event.isPagination) {
        yield HomeLoading();
      } else {
        yield CharacterList(event.oldData, event.page, isPaginationLoading: true);
      }
      final response = await repository.getCharacters(page: event.page);
      if (response.success) {
        if (response.data?.isEmpty == true) {
          yield HomeNoData("No Characters available");
        }
        if (event.isPagination) {
          currentState = CharacterList(
              event.oldData..addAll(response.data ?? []), event.page);
        } else {
          currentState = CharacterList(response.data ?? [], 0);
        }
      } else {
        currentState =
            HomeError(response.message ?? "Error", response.code ?? -1);
      }
    }

    if (event is HomeSearchEvent) {
      yield HomeLoading();
      final response = await repository.searchCharacters(event.query);
      if (response.success) {
        if (response.data?.isEmpty == true) {

          currentState = HomeNoData("No Characters available with ${event.query}");
        }
        else {
          currentState = CharacterList(response.data ?? [], 0);
        }
      } else {
        currentState =
            HomeError(response.message ?? "Error", response.code ?? -1);
      }
    }

    yield currentState;
  }
}
