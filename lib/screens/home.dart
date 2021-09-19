import 'package:flutter/material.dart';
import 'package:posts_app/blocs/albums_bloc.dart';
import 'package:posts_app/blocs/posts_bloc.dart';
import 'package:posts_app/blocs/profile_bloc.dart';
import 'package:posts_app/blocs/todo_list_bloc.dart';
import 'package:posts_app/providers/bloc_provider.dart';
import 'package:posts_app/screens/albums.dart';
import 'package:posts_app/screens/posts.dart';
import 'package:posts_app/screens/profile.dart';
import 'package:posts_app/screens/to_do_list.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const route = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    Provider<PostsBloc>(
      create: (BuildContext context) => providePostsBloc(),
      child: const Posts(),
    ),
    Provider<AlbumsBloc>(
      create: (BuildContext context) => provideAlbumsBloc(),
      child: const Albums(),
    ),
    Provider<TodoListBloc>(
      create: (BuildContext context) => provideTodoListBLoc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: const TodoListScreen(),
    ),
    Provider<ProfileBloc>(
      create: (BuildContext context) => provideProfileBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: const Profile(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.tundora,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.whileLilacAlpha,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_sharp),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
              ),
              label: 'Albums'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message_sharp,
              ),
              label: 'Todo'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_sharp,
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
