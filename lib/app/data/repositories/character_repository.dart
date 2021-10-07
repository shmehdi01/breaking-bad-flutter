import 'package:breakingbad/app/data/models/request/pagination.dart';
import 'package:breakingbad/app/data/models/response/base_response.dart';
import 'package:breakingbad/app/data/network/api_provider.dart';
import 'package:breakingbad/app/data/network/api_service.dart';
import 'package:breakingbad/app/ui/characters/models/character.dart';

class CharacterRepository {
  
  final ApiService apiService = ApiProvider('https://www.breakingbadapi.com/api/');
  
  Future<BaseResponse<List<Character>>> getCharacters({required int page, int limit = 10}) {
    return apiService.getCharacters(PaginationRequest(limit: limit, offset: page*limit));
  }

  Future<BaseResponse<List<Character>>> searchCharacters(String query) {
    return apiService.searchCharacters(query, PaginationRequest(limit: 10, offset: 0));
  }

  Future<BaseResponse<List<Character>>> getCharacter(int characterId) {
    return apiService.getCharacter(characterId);
  }
}