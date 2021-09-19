import 'package:flutter/material.dart';
import 'package:posts_app/blocs/todo_list_bloc.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:posts_app/theme/text_styles.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoListBloc? _bloc;
  @override
  void didChangeDependencies() {
    _bloc ??= Provider.of<TodoListBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getHeader(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            StreamBuilder<List<TodoList>>(
              stream: _bloc!.todosList,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final todos = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...todos!.map(
                          (todo) {
                            return _TodoListCard(todo: todo);
                          },
                        ).toList(),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Container(
      color: AppColors.tundora,
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.15,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        top: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Text(
        "Todo List",
        style: TextStyles.textFieldTitle().copyWith(fontSize: 22),
      ),
    );
  }
}

class _TodoListCard extends StatelessWidget {
  final TodoList todo;
  const _TodoListCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: AppColors.tundora,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        margin: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.03,
        ),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                todo.isCompleted ? "Completed" : "Incomplete",
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
