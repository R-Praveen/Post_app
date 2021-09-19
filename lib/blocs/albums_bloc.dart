import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/albums_repository.dart';
import 'package:rxdart/rxdart.dart';

class AlbumsBloc {
  final userAlbums = BehaviorSubject<List<Album>>();
  final AlbumsRepository repository;
  AlbumsBloc({
    required this.repository,
  }) {
    initDetails();
  }

  Future initDetails() async {
    await repository.fetchAlbums();
    final albumsList = await repository.getAlbums();
    userAlbums.add(albumsList);
  }

  void dispose() {
    userAlbums.close();
  }
}
