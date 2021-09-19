import 'package:flutter/material.dart';
import 'package:posts_app/screens/comments_screen.dart';
import 'package:posts_app/screens/create_post.dart';
import 'package:posts_app/screens/home.dart';
import 'package:posts_app/screens/login.dart';
import 'package:posts_app/screens/photos.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  '/': (_) => const LoginPage(),
  Home.route: (_) => const Home(),
  LoginPage.route: (_) => const LoginPage(),
  Photos.route: (_) => const Photos(),
  CommentsScreen.route: (_) => const CommentsScreen(),
  CreatePost.route: (_) => const CreatePost(),
};
