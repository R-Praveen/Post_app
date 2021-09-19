import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/albums_repository.dart';
import 'package:rxdart/rxdart.dart';

class AlbumsBloc {
  //Storing album details
  final userAlbums = BehaviorSubject<List<Album>>();
  final AlbumsRepository repository;
  AlbumsBloc({
    required this.repository,
  }) {
    initDetails();
  }
  /*Making network call to fetch the latest albums and saving in local
  and getting albums from the local */
  Future initDetails() async {
    await repository.fetchAlbums();
    final albumsList = await repository.getAlbums();
    userAlbums.add(albumsList);
  }

  /*
  closing all streams 
  */
  void dispose() {
    userAlbums.close();
  }
}
