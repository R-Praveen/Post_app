import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/todos_list_repository.dart';
import 'package:rxdart/subjects.dart';

class TodoListBloc {
  final todosList = BehaviorSubject<List<TodoList>>();

  final TodosListRepository repository;
  TodoListBloc({required this.repository}) {
    initDetails();
  }

  Future initDetails() async {
    await repository.fetchTodoList();
    final todos = await repository.getTodoList();
    todosList.add(todos);
  }

  void dispose() {
    todosList.close();
  }
}
