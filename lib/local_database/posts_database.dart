import 'package:moor_flutter/moor_flutter.dart';
import 'package:posts_app/local_database/app_database.dart';

part 'posts_database.g.dart';

@UseDao(
  tables: [Posts],
)
class PostsDao extends DatabaseAccessor<AppDatabase> with _$PostsDaoMixin {
  final AppDatabase db;
  PostsDao(this.db) : super(db);

  Future savePosts(List<Post> entries) async {
    batch(
      (batch) => batch.insertAllOnConflictUpdate(
        posts,
        entries,
      ),
    );
  }

  Future savePost(Post post) async {
    into(posts).insertOnConflictUpdate(post);
  }

  Future<List<Post>> getPosts() async {
    return select(posts).get();
  }
}

class Posts extends Table {
  TextColumn get id => text()();
  TextColumn get userID => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();

  @override
  Set<Column> get primaryKey => {id};
}
