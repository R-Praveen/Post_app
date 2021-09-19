import 'package:moor_flutter/moor_flutter.dart';
import 'package:posts_app/local_database/app_database.dart';

part 'comments_database.g.dart';

@UseDao(
  tables: [Comments],
)
class CommentsDao extends DatabaseAccessor<AppDatabase>
    with _$CommentsDaoMixin {
  final AppDatabase db;
  CommentsDao(this.db) : super(db);

  Future saveComments(List<Comment> entries) async {
    batch(
      (batch) => batch.insertAllOnConflictUpdate(
        comments,
        entries,
      ),
    );
  }

  Future<List<Comment>> getComments(String postId) async {
    return (select(comments)..where((tbl) => tbl.postId.equals(postId))).get();
  }
}

class Comments extends Table {
  TextColumn get id => text()();
  TextColumn get postId => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get body => text()();

  @override
  Set<Column> get primaryKey => {id};
}
