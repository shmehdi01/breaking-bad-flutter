import 'package:breakingbad/app/data/models/dto/character.dart';

class BaseResponse<T> extends GenericParser<T> {
  late bool success;
  T? data;
  String? message;
  int? code;

  BaseResponse(
      {required this.success, required this.data, this.code, this.message});

  factory BaseResponse.fromError(String errorMessage, {int? errorCode}) {
    return BaseResponse(
        success: false, data: null, message: errorMessage, code: errorCode);
  }

  BaseResponse.fromJson(Map<String, dynamic> json) {
    success = true;
    data = parse(json);
  }

  BaseResponse.fromJsonList(List<dynamic> list) {
    success = true;
    data = parseList(list);
  }

  @override
  String toString() {
    return "status => $success\ncode => $code\ndata => $data\nmessage => $message";
  }
}

abstract class GenericParser<T> {
  T? parse(Map<String, dynamic> json) {
    T? t;
    if (_isSubtype<T, List<Character>>()) {
      final data = <Character>[];
      json.forEach((key, value) {
        final e = Character.fromJson(value);
        data.add(e);
      });
      t = data as T;
    }

    if (T == Character) {
      final data = Character.fromJson(json);
      t = data as T;
    }

    return t;
  }

  T? parseList(List<dynamic> json) {
    T? t;
    if (_isSubtype<T, List<Character>>()) {
      final data = <Character>[];
      for (var value in json) {
        final e = Character.fromJson(value);
        data.add(e);
      }
      t = data as T;
    }

    return t;
  }

  bool _isSubtype<T1, T2>() => <T1>[] is List<T2>;
}
