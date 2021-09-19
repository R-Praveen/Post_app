import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:posts_app/blocs/posts_bloc.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/screens/comments_screen.dart';
import 'package:posts_app/screens/create_post.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  PostsBloc? _bloc;
  @override
  void didChangeDependencies() {
    _bloc ??= Provider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text("Posts"),
        backgroundColor: AppColors.tundora,
      ),
      body: StreamBuilder<List<Post>>(
        stream: _bloc!.posts,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...snapshot.data!.map((post) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                        vertical: MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: postItem(post),
                    );
                  }).toList()
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreatePost.route);
        },
        backgroundColor: AppColors.green,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget postItem(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title,
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          post.body,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: AppColors.white,
          ),
        ),
        Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                CommentsScreen.route,
                arguments: CommentsScreenArgument(
                  postId: post.id,
                ),
              );
            },
            child: const Text(
              "view comments",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommentsScreenArgument {
  final String postId;
  CommentsScreenArgument({
    required this.postId,
  });
}
