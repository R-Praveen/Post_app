import 'package:flutter/material.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/local_database/photos_database.dart';
import 'package:posts_app/services/photos_services.dart';

class PhotosRepository {
  final PhotosServices services;
  final PhotosDao dao;
  PhotosRepository({
    required this.services,
    required this.dao,
  });

  Future fetchPhotos(String albumID) async {
    try {
      final photos = await services.fetchPhotos(albumID);
      final List<Photo> photosList = [];
      for (final photo in photos) {
        photosList.add(
          Photo(
            id: photo["id"].toString(),
            albumId: photo["albumId"].toString(),
            thumbNailUrl: photo["thumbnailUrl"],
            title: photo["title"],
            url: photo["url"],
          ),
        );
      }
      await savePhotos(photosList);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future savePhotos(List<Photo> photos) async {
    await dao.savePhotos(photos);
  }

  Future getPhotos(String albumId) async {
    return dao.getPhotos(albumId);
  }
}
