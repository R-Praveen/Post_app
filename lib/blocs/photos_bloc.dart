import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/photos_repository.dart';
import 'package:rxdart/rxdart.dart';

class PhotosBloc {
  final photos = BehaviorSubject<List<Photo>>();
  final PhotosRepository repository;
  final String albumId;
  final String title;
  PhotosBloc({
    required this.albumId,
    required this.title,
    required this.repository,
  }) {
    initDetails();
  }

  Future initDetails() async {
    await repository.fetchPhotos(albumId);
    final albumPhotos = await repository.getPhotos(albumId);
    photos.add(albumPhotos);
  }

  void dispose() {
    photos.close();
  }
}
