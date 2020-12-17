
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dio = new Dio(new BaseOptions(
    baseUrl: 'http://192.168.43.97:8080',
    receiveDataWhenStatusError: true,
    connectTimeout: 60 * 1000,
    receiveTimeout: 60 * 1000));

class Api {

  String apiUrl = 'http://192.168.43.97:8080';

  Api() {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
  }

  Future<Response> login(String username, String password) async {
    String path = '/api/quarantine/login';

    return await dio.post(path, data: {
      "username": username,
      "password": password,
    });
  }

  Future<Response> getInfo(String token) async {
    String path = '/api/quarantine/info';

    return await dio.get(path,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }

  Future<Response> uploadImage(File imageFile, String token) async {
    String path = '/api/quarantine/upload-profile';

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path,
          filename: basename(imageFile.path))
    });

    return await dio.post(path,
        data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }


}