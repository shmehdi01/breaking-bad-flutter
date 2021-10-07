import 'package:breakingbad/app/data/models/request/pagination.dart';
import 'package:breakingbad/app/data/models/response/base_response.dart';
import 'package:breakingbad/app/data/network/api_service.dart';
import 'package:breakingbad/app/data/network/dio_network_extension.dart';
import 'package:breakingbad/app/ui/characters/models/character.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiProvider implements ApiService {
  final String baseUrl;

  late Dio _dio;

  ApiProvider(this.baseUrl) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(
        PrettyDioLogger(
            requestBody: kDebugMode,
            requestHeader: kDebugMode,
            responseBody: kDebugMode),
      );
  }

  @override
  Future<BaseResponse<List<Character>>> getCharacters(
      PaginationRequest pagination) {
    return _dio
        .get('characters', queryParameters: pagination.toParams())
        .safeApiCall();
  }

  @override
  Future<BaseResponse<List<Character>>> searchCharacters(String query, PaginationRequest pagination) {
    final map = pagination.toParams();
    map['name'] = query;
    return _dio
        .get('characters', queryParameters: map)
        .safeApiCall();
  }

  @override
  Future<BaseResponse<List<Character>>> getCharacter(int characterId) {
    return _dio
        .get('characters/$characterId')
        .safeApiCall();
  }
}
