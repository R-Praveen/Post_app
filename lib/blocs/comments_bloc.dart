import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/comments_repository.dart';
import 'package:rxdart/subjects.dart';

class CommentsBloc {
  //Storing comments
  final comments = BehaviorSubject<List<Comment>>();

  final CommentsRepository repository;
  final String postId;
  CommentsBloc({
    required this.postId,
    required this.repository,
  }) {
    initDetails();
  }

  /*Making network call to fetch the latest comments based on Post ID 
  and saving in local
  and getting comments from the local */
  Future initDetails() async {
    await repository.fetchComments(postId);
    final commentsList = await repository.getComments(postId);
    comments.add(commentsList);
  }

  /*
  closing all streams 
  */
  void dispose() {
    comments.close();
  }
}
