
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dio = new Dio(new BaseOptions(
    baseUrl: 'http://192.168.43.97:8080',
    receiveDataWhenStatusError: true,
    connectTimeout: 60 * 1000,
    receiveTimeout: 60 * 1000));

class Api {
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


}