import 'package:breakingbad/app/data/repositories/character_repository.dart';
import 'package:breakingbad/app/ui/base/base_bloc.dart';
import 'package:breakingbad/app/ui/characters/detail/bloc/character_detail_event.dart';
import 'package:breakingbad/app/ui/characters/detail/bloc/character_detail_state.dart';

class CharacterDetailBloc extends BaseBloc<CharacterDetailEvent, CharacterDetailState> {

  final CharacterRepository repository = CharacterRepository();

  @override
  Stream<CharacterDetailState> mapEventToState(CharacterDetailEvent event) async* {
     if (event is LoadCharacter) {
        yield LoadingDetailCharacter();
        final response = await repository.getCharacter(event.characterId);
        if (response.success) {
          if (response.data?.isEmpty == true) {
            yield CharacterNotFound();
          }
          else {
            yield CharacterData(data: response.data![0]);
          }
        }
        else {
          yield CharacterDetailError(response.message ?? "Error", response.code ?? -1);
        }
     }
  }


}