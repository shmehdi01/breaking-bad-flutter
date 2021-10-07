import 'package:breakingbad/app/data/models/response/base_response.dart';
import 'package:dio/dio.dart';

extension FutureResponse on Future<Response> {
  Future<BaseResponse<T>> safeApiCall<T>() async {
    try {
      final Response response = await this;
      try {
        if (response.statusCode == 200) {
          BaseResponse<T> baseResponse = response.data is List ? BaseResponse.fromJsonList(response.data) : BaseResponse.fromJson(response.data);
          return baseResponse;
        }
        else {
          return BaseResponse.fromError("Something went wrong");
        }
      }catch(e) {
        return BaseResponse.fromError(e.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return _handleDioError<T>(e);
      }
      return BaseResponse.fromError(e.toString(),);
    }
  }
}

BaseResponse<T> _handleDioError<T>(DioError e) {
  switch (e.type) {
    case DioErrorType.connectTimeout:
      return BaseResponse.fromError("Connection timeout");

    case DioErrorType.sendTimeout:
      return BaseResponse.fromError("Send timeout");

    case DioErrorType.receiveTimeout:
      return BaseResponse.fromError("Receive timeout");

    case DioErrorType.response:
      return BaseResponse.fromError(
        "Something went wrong",
        errorCode: e.response?.statusCode,
      );
    case DioErrorType.cancel:
      return BaseResponse.fromError("Request has been cancelled");

    case DioErrorType.other:
      return BaseResponse.fromError("Could not connect");
  }
}
