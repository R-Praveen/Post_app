import 'package:moor_flutter/moor_flutter.dart';
import 'package:posts_app/local_database/app_database.dart';
part 'photos_database.g.dart';

@UseDao(
  tables: [Photos],
)
class PhotosDao extends DatabaseAccessor<AppDatabase> with _$PhotosDaoMixin {
  final AppDatabase db;
  PhotosDao(this.db) : super(db);

  Future savePhotos(List<Photo> entries) async {
    batch(
      (batch) => batch.insertAllOnConflictUpdate(
        photos,
        entries,
      ),
    );
  }

  Future getPhotos(String albumId) async {
    return (select(photos)..where((tbl) => tbl.albumId.equals(albumId))).get();
  }
}

class Photos extends Table {
  TextColumn get id => text()();
  TextColumn get albumId => text()();
  TextColumn get title => text()();
  TextColumn get url => text()();
  TextColumn get thumbNailUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}
