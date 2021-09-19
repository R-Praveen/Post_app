import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TodoListServices {
  Dio dio = Dio();
  Future fetchTodoLists(String id) async {
    String url = 'https://jsonplaceholder.typicode.com/users/$id/todos';
    Response? response;
    try {
      response = await dio.get(url);
    } catch (e) {
      debugPrint(e.toString());
    }
    return response?.data;
  }
}
