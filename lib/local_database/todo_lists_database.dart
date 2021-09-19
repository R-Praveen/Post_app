import 'package:moor_flutter/moor_flutter.dart';
import 'package:posts_app/local_database/app_database.dart';
part 'todo_lists_database.g.dart';

@UseDao(
  tables: [TodoLists],
)
class TodoListsDao extends DatabaseAccessor<AppDatabase>
    with _$TodoListsDaoMixin {
  final AppDatabase db;
  TodoListsDao(this.db) : super(db);

  Future<void> saveTodos(List<TodoList> entries) async {
    batch(
      (batch) => batch.insertAllOnConflictUpdate(
        todoLists,
        entries,
      ),
    );
  }

  Future<List<TodoList>> getTodoList() async {
    return select(todoLists).get();
  }
}

class TodoLists extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  BoolColumn get isCompleted => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
