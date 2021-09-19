import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:posts_app/blocs/comments_bloc.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/providers/repository_provider.dart';
import 'package:posts_app/screens/posts.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  static const route = '/comments';
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as CommentsScreenArgument;

    return Provider<CommentsBloc>(
      create: (BuildContext context) => CommentsBloc(
        postId: arguments.postId,
        repository: provideCommentsRepository(),
      ),
      dispose: (_, bloc) => bloc.dispose(),
      child: Builder(builder: (context) {
        final bloc = Provider.of<CommentsBloc>(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.tundora,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text(
              "View comments",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: AppColors.black,
          body: StreamBuilder<List<Comment>>(
              stream: bloc.comments,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final value = snapshot.data ?? [];
                  if (value.isEmpty) {
                    return const Center(
                      child: Text(
                        "No comments to show",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: Column(
                        children: [
                          ...value.map((comment) {
                            return _getItem(context, comment);
                          })
                        ],
                      ),
                    ),
                  );
                }
              }),
        );
      }),
    );
  }

  Widget _getItem(BuildContext context, Comment comment) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  comment.name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                comment.email,
                style:
                    const TextStyle(color: AppColors.alphaWhite, fontSize: 15),
              ),
            ],
          ),
          Text(
            comment.body,
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
