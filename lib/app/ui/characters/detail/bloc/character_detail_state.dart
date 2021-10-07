import 'package:breakingbad/app/ui/base/base_state.dart';
import 'package:breakingbad/app/ui/characters/models/character.dart';

abstract class CharacterDetailState implements BlocState {}

class LoadingDetailCharacter implements CharacterDetailState {}

class CharacterData implements CharacterDetailState {
  final Character data;

  CharacterData({required this.data});
}

class CharacterDetailError extends ErrorState implements CharacterDetailState {
  CharacterDetailError(String message, int code) : super(message, code);
}

class CharacterNotFound implements CharacterDetailState {

}
