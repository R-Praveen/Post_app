import 'package:flutter/foundation.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/local_database/comments_database.dart';
import 'package:posts_app/services/comments_services.dart';

class CommentsRepository {
  final CommentsServices services;
  final CommentsDao dao;
  CommentsRepository({
    required this.services,
    required this.dao,
  });

  Future fetchComments(String postId) async {
    final comments = await services.fetchComments(postId);
    if (comments != null) {
      final List<Comment> commentsList = [];
      for (final comment in comments) {
        commentsList.add(
          Comment(
            id: comment["id"].toString(),
            postId: comment["postId"].toString(),
            name: comment["name"],
            email: comment["email"],
            body: comment["body"],
          ),
        );
      }
      await saveComments(commentsList);
    }
  }

  Future saveComments(List<Comment> comments) async {
    await dao.saveComments(comments);
  }

  Future<List<Comment>> getComments(String postId) async {
    List<Comment>? comments;
    try {
      comments = await dao.getComments(postId);
    } catch (e) {
      debugPrint(e.toString());
    }
    return comments ?? [];
  }
}
