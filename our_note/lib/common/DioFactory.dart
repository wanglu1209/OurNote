import 'package:dio/dio.dart';

class DioFactory {
  static Dio _instance;

  static Dio getDio() {
    if (_instance == null) {
      _instance = Dio()..options.connectTimeout = 5000;
    }
    return _instance;
  }
}
