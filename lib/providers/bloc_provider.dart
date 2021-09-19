import 'package:posts_app/blocs/albums_bloc.dart';
import 'package:posts_app/blocs/comments_bloc.dart';
import 'package:posts_app/blocs/create_post_bloc.dart';
import 'package:posts_app/blocs/photos_bloc.dart';
import 'package:posts_app/blocs/posts_bloc.dart';
import 'package:posts_app/blocs/profile_bloc.dart';
import 'package:posts_app/blocs/todo_list_bloc.dart';
import 'package:posts_app/providers/repository_provider.dart';

PostsBloc providePostsBloc() {
  return PostsBloc(
    postsRepository: providePostsRepository(),
  );
}

CommentsBloc provideCommentsBloc(String postID) {
  return CommentsBloc(
    postId: postID,
    repository: provideCommentsRepository(),
  );
}

ProfileBloc provideProfileBloc() {
  return ProfileBloc(
    repository: provideLoginRepository(),
  );
}

TodoListBloc provideTodoListBLoc() {
  return TodoListBloc(
    repository: provideTodoListRepository(),
  );
}

AlbumsBloc provideAlbumsBloc() {
  return AlbumsBloc(
    repository: provideAlbumsRepository(),
  );
}

PhotosBloc providePhotosBloc(
  String albumId,
  String title,
) {
  return PhotosBloc(
    albumId: albumId,
    title: title,
    repository: providePhotosRepository(),
  );
}

CreatePostBloc provideCreatePostBloc() {
  return CreatePostBloc(
    repository: providePostsRepository(),
    loginRepository: provideLoginRepository(),
  );
}
