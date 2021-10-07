import 'package:breakingbad/app/data/models/request/pagination.dart';
import 'package:breakingbad/app/data/models/response/base_response.dart';
import 'package:breakingbad/app/ui/characters/models/character.dart';

abstract class ApiService {

  Future<BaseResponse<List<Character>>> getCharacters(PaginationRequest pagination);

  Future<BaseResponse<List<Character>>> getCharacter(int characterId);

  Future<BaseResponse<List<Character>>> searchCharacters(String query,PaginationRequest pagination);

}