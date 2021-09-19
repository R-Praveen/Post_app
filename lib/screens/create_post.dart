import 'package:flutter/material.dart';
import 'package:posts_app/blocs/create_post_bloc.dart';
import 'package:posts_app/providers/bloc_provider.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:posts_app/theme/text_styles.dart';
import 'package:posts_app/widgets/app_button.dart';
import 'package:posts_app/widgets/bordered_text_field.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  static const route = '/create_post';
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Provider<CreatePostBloc>(
      create: (BuildContext context) => provideCreatePostBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: Builder(builder: (context) {
        final bloc = Provider.of<CreatePostBloc>(context);
        bloc.postAdded.listen((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
        return Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            backgroundColor: AppColors.tundora,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            centerTitle: true,
            title: Text(
              "Create Post",
              style: TextStyles.textFieldTitle(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BorderedTextField(
                    textStream: bloc.title,
                    errorStream: bloc.errTitle,
                    onTextChanged: (String value) => bloc.onTitleChanged(value),
                    title: "Title",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  BorderedTextField(
                    textStream: bloc.post,
                    maxLines: 4,
                    errorStream: bloc.errPost,
                    onTextChanged: (String value) => bloc.onPostChanged(value),
                    title: "Post",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: AppButton(
                      child: const Text(
                        "Submit post",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => bloc.submit(),
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
