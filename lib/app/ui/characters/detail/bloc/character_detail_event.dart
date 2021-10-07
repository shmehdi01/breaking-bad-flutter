import 'package:breakingbad/app/ui/base/base_state.dart';

abstract class CharacterDetailEvent implements BlocEvent {}

class LoadCharacter implements CharacterDetailEvent {
  final int characterId;

  LoadCharacter(this.characterId);
}