import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AlbumServices {
  Dio dio = Dio();
  Future fetchAlbums(String id) async {
    String url = 'https://jsonplaceholder.typicode.com/users/$id/albums';
    Response? response;
    try {
      response = await dio.get(url);
    } catch (e) {
      debugPrint(e.toString());
    }
    return response?.data;
  }
}
