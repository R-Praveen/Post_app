import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PostsServices {
  Dio dio = Dio();
  Future fetchPosts(String userID) async {
    String url = 'https://jsonplaceholder.typicode.com/posts?userId=$userID';
    Response? response;
    try {
      response = await dio.get(url);
    } catch (e) {
      debugPrint(e.toString());
    }
    return response?.data;
  }
}
