import 'package:moor_flutter/moor_flutter.dart';
import 'package:posts_app/local_database/albums_database.dart';
import 'package:posts_app/local_database/comments_database.dart';
import 'package:posts_app/local_database/photos_database.dart';
import 'package:posts_app/local_database/posts_database.dart';
import 'package:posts_app/local_database/todo_lists_database.dart';
import 'package:posts_app/local_database/users_database.dart';
part 'app_database.g.dart';

@UseMoor(
  tables: [Users, TodoLists, Albums, Photos, Posts, Comments],
  daos: [
    UsersDao,
    TodoListsDao,
    AlbumsDao,
    PhotosDao,
    PostsDao,
    CommentsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            logStatements: true,
          ),
        );
  static AppDatabase? _instance;

  factory AppDatabase.instance() {
    return _instance ??= AppDatabase();
  }
  @override
  int get schemaVersion => 1;

  Future<void> clearUserRelatedTables() async {
    for (final table in userRelatedTables) {
      await delete(table).go();
    }
  }

  /*Deleting all user related tables to clear all information 
  once they log out, except the users table as we shall keep those 
  and check for password match in case the already logged in user logs in again.
  */
  List<TableInfo> get userRelatedTables => [
        posts,
        photos,
        albums,
        todoLists,
        comments,
      ];
}
