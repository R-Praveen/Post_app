import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PhotosServices {
  Dio dio = Dio();
  Future fetchPhotos(String id) async {
    String url = 'https://jsonplaceholder.typicode.com/albums/$id/photos';
    Response? response;
    try {
      response = await dio.get(url);
    } catch (e) {
      debugPrint(e.toString());
    }
    return response?.data;
  }
}
