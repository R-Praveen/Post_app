import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/posts_repository.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc {
  final posts = BehaviorSubject<List<Post>>();

  final PostsRepository postsRepository;
  PostsBloc({
    required this.postsRepository,
  }) {
    initDetails();
  }

  Future initDetails() async {
    await postsRepository.fetchPosts();
    final postsList = await postsRepository.getPosts();
    posts.add(postsList);
  }

  void dispose() {
    posts.close();
  }
}
