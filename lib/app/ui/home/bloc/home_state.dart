import 'package:breakingbad/app/ui/base/base_state.dart';
import 'package:breakingbad/app/ui/characters/models/character.dart';

abstract class HomeState extends BlocState {}

class Idle implements HomeState {}

class HomeLoading implements HomeState {
}

class SearchView implements HomeState {}

class NormalView implements HomeState {}

class HomeError extends ErrorState implements HomeState  {
  HomeError(String message, int code) : super(message, code);
}

class CharacterList extends HomeState {
  final int currentPage;
  final List<Character> data;
  final bool isPaginationLoading;
  CharacterList(this.data, this.currentPage, {this.isPaginationLoading = false});
}


class HomeNoData implements HomeState {
  final String message;
  HomeNoData(this.message);
}

