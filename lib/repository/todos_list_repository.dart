import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/local_database/todo_lists_database.dart';
import 'package:posts_app/repository/login_repository.dart';
import 'package:posts_app/services/todo_list_services.dart';

class TodosListRepository {
  final TodoListServices services;
  final LoginRepository loginRepository;
  final TodoListsDao dao;
  TodosListRepository({
    required this.services,
    required this.loginRepository,
    required this.dao,
  });

  Future fetchTodoList() async {
    final user = await loginRepository.getLoggedInUser();
    final todos = await services.fetchTodoLists(user?.id ?? '');
    final List<TodoList> todoList = [];
    for (final todo in todos) {
      todoList.add(
        TodoList(
          id: todo["id"].toString(),
          userId: todo["userId"].toString(),
          title: todo["title"],
          isCompleted: todo["completed"] as bool,
        ),
      );
    }
    await dao.saveTodos(todoList);
  }

  Future<List<TodoList>> getTodoList() async {
    return dao.getTodoList();
  }
}
