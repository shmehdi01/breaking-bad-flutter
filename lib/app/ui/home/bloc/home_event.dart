// enum HomeEvent  {
//   loadCharacters, searchView, normalView
// }

import 'package:breakingbad/app/data/models/dto/character.dart';

abstract class HomeEvent {

}

class HomeSearchEvent implements HomeEvent {
   final String query;
   HomeSearchEvent(this.query);
}

class LoadCharacters implements HomeEvent {
  int page;
  bool isPagination;
  List<Character> oldData;

  LoadCharacters({this.page = 0, this.oldData = const [], this.isPagination = false});
}

class SearchViewEvent implements HomeEvent {
  final bool show;
  SearchViewEvent({required this.show});
}