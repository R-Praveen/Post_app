import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/albums_repository.dart';
import 'package:posts_app/repository/comments_repository.dart';
import 'package:posts_app/repository/login_repository.dart';
import 'package:posts_app/repository/photos_repository.dart';
import 'package:posts_app/repository/posts_repository.dart';
import 'package:posts_app/repository/todos_list_repository.dart';
import 'package:posts_app/services/album_services.dart';
import 'package:posts_app/services/comments_services.dart';
import 'package:posts_app/services/login_services.dart';
import 'package:posts_app/services/photos_services.dart';
import 'package:posts_app/services/posts_services.dart';
import 'package:posts_app/services/todo_list_services.dart';

AppDatabase provideAppDatabase() {
  return AppDatabase.instance();
}

LoginRepository provideLoginRepository() {
  return LoginRepository(
    services: LoginServices(),
    usersDao: provideAppDatabase().usersDao,
  );
}

TodosListRepository provideTodoListRepository() {
  return TodosListRepository(
    services: TodoListServices(),
    loginRepository: provideLoginRepository(),
    dao: provideAppDatabase().todoListsDao,
  );
}

AlbumsRepository provideAlbumsRepository() {
  return AlbumsRepository(
    services: AlbumServices(),
    loginRepository: provideLoginRepository(),
    dao: provideAppDatabase().albumsDao,
  );
}

PhotosRepository providePhotosRepository() {
  return PhotosRepository(
    services: PhotosServices(),
    dao: provideAppDatabase().photosDao,
  );
}

PostsRepository providePostsRepository() {
  return PostsRepository(
    services: PostsServices(),
    loginRepository: provideLoginRepository(),
    dao: provideAppDatabase().postsDao,
  );
}

CommentsRepository provideCommentsRepository() {
  return CommentsRepository(
    services: CommentsServices(),
    dao: provideAppDatabase().commentsDao,
  );
}
