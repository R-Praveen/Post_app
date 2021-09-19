import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/comments_repository.dart';
import 'package:rxdart/subjects.dart';

class CommentsBloc {
  final comments = BehaviorSubject<List<Comment>>();
  final CommentsRepository repository;
  final String postId;
  CommentsBloc({
    required this.postId,
    required this.repository,
  }) {
    initDetails();
  }

  Future initDetails() async {
    await repository.fetchComments(postId);
    final commentsList = await repository.getComments(postId);
    comments.add(commentsList);
  }

  void dispose() {
    comments.close();
  }
}
