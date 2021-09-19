import 'package:flutter/rendering.dart';
import 'package:posts_app/local_database/albums_database.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/login_repository.dart';
import 'package:posts_app/services/album_services.dart';

class AlbumsRepository {
  final AlbumServices services;
  final LoginRepository loginRepository;
  final AlbumsDao dao;
  AlbumsRepository({
    required this.services,
    required this.loginRepository,
    required this.dao,
  });

  Future fetchAlbums() async {
    try {
      final user = await loginRepository.getLoggedInUser();
      final albums = await services.fetchAlbums(user?.id ?? '');
      final List<Album> albumList = [];
      for (final album in albums) {
        albumList.add(
          Album(
            id: album["id"].toString(),
            userId: album["userId"].toString(),
            title: album["title"],
          ),
        );
      }
      await saveAlbums(albumList);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future saveAlbums(List<Album> albums) async {
    await dao.saveAlbums(albums);
  }

  Future getAlbums() async {
    return dao.getAlbums();
  }
}
