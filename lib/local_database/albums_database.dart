import 'package:moor_flutter/moor_flutter.dart';
import 'package:posts_app/local_database/app_database.dart';
part 'albums_database.g.dart';

@UseDao(
  tables: [Albums],
)
class AlbumsDao extends DatabaseAccessor<AppDatabase> with _$AlbumsDaoMixin {
  final AppDatabase db;
  AlbumsDao(this.db) : super(db);

  Future saveAlbums(List<Album> entries) async {
    batch(
      (batch) => batch.insertAllOnConflictUpdate(
        albums,
        entries,
      ),
    );
  }

  Future getAlbums() async {
    return select(albums).get();
  }
}

class Albums extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();

  @override
  Set<Column> get primaryKey => {id};
}
