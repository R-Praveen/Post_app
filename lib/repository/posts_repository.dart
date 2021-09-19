import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/local_database/posts_database.dart';
import 'package:posts_app/repository/login_repository.dart';
import 'package:posts_app/services/posts_services.dart';

class PostsRepository {
  final PostsServices services;
  final LoginRepository loginRepository;
  final PostsDao dao;
  PostsRepository({
    required this.services,
    required this.loginRepository,
    required this.dao,
  });

  Future fetchPosts() async {
    final user = await loginRepository.getLoggedInUser();
    final rawPosts = await services.fetchPosts(user?.id ?? '');
    final List<Post> posts = [];
    for (final post in rawPosts) {
      posts.add(
        Post(
          id: post["id"].toString(),
          userID: post["userId"].toString(),
          title: post["title"],
          body: post["body"],
        ),
      );
    }
    await savePosts(posts);
  }

  Future savePost(Post post) async {
    await dao.savePost(post);
  }

  Future savePosts(List<Post> posts) async {
    await dao.savePosts(posts);
  }

  Future<List<Post>> getPosts() async {
    return dao.getPosts();
  }
}
