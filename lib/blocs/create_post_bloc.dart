import 'package:flutter/rendering.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/login_repository.dart';
import 'package:posts_app/repository/posts_repository.dart';
import 'package:rxdart/subjects.dart';

class CreatePostBloc {
  //Fields
  final title = BehaviorSubject<String>();
  final post = BehaviorSubject<String>();

  //Errors
  final errTitle = BehaviorSubject<String>();
  final errPost = BehaviorSubject<String>();

  final postAdded = BehaviorSubject<bool>();
  final PostsRepository repository;
  final LoginRepository loginRepository;
  CreatePostBloc({
    required this.repository,
    required this.loginRepository,
  });

  void onTitleChanged(String value) {
    title.add(value);
    if (value.isEmpty) {
      errTitle.add("Please enter the title");
    } else {
      errTitle.add('');
    }
  }

  void onPostChanged(String value) {
    post.add(value);
    if (value.isEmpty) {
      errPost.add("Please enter the post");
    } else {
      errPost.add('');
    }
  }

  Future submit() async {
    final titleValue = title.hasValue ? title.value : '';
    final postValue = post.hasValue ? post.value : '';
    if (titleValue.isEmpty) {
      errTitle.add("Please enter the title");
    }
    if (postValue.isEmpty) {
      errPost.add("Please enter the post");
    }
    final posts = await repository.getPosts();
    String id = posts.last.id;
    final user = await loginRepository.getLoggedInUser();
    int newPostID = int.parse(id) + 100;
    Post newPost = Post(
      id: newPostID.toString(),
      userID: user?.id ?? '',
      title: titleValue,
      body: postValue,
    );
    try {
      await repository.savePost(newPost).then((value) {
        debugPrint('');
      });
      postAdded.add(true);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dispose() {
    title.close();
    post.close();
    errTitle.close();
    errPost.close();
    postAdded.close();
  }
}
