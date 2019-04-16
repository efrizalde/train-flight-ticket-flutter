import 'dart:convert';

import 'package:dio/dio.dart';

class RestApiUtil {
  static RestApiUtil _instance = new RestApiUtil.internal();
  RestApiUtil.internal();
  factory RestApiUtil() => _instance;

  final Dio dio = new Dio();

  // HTTP GET Method
  Future<dynamic> get(String url) {
    return dio.get(url).then((Response response) {
      final res = response.data;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  // HTTP POST Method
  Future<dynamic> post(String url, {body, Options options}) {
    return dio
        .post(url, data: body, options: options)
        .then((Response response) {
      final res = response.data;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(res);
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  // HTTP PUT Method
  Future<dynamic> put(String url, {body, Options options}) {
    return dio.put(url, data: body, options: options).then((Response response) {
      final res = response.data;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }
}
