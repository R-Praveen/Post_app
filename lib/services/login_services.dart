import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoginServices {
  Dio dio = Dio();
  Future fetchUsers() async {
    String url = 'https://jsonplaceholder.typicode.com/users';
    Response? response;
    try {
      response = await dio.get(url);
    } catch (e) {
      debugPrint(e.toString());
    }
    return response?.data;
  }
}
