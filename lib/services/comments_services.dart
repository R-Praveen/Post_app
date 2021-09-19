import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CommentsServices {
  Dio dio = Dio();
  Future fetchComments(String postID) async {
    String url = 'https://jsonplaceholder.typicode.com/posts/$postID/comments';
    Response? response;
    try {
      response = await dio.get(url);
    } catch (e) {
      debugPrint(e.toString());
    }
    return response?.data;
  }
}
