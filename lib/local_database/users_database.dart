import 'package:moor_flutter/moor_flutter.dart';
import 'package:posts_app/local_database/app_database.dart';
part 'users_database.g.dart';

@UseDao(
  tables: [Users],
)
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;
  UsersDao(this.db) : super(db);

  Future<void> saveUsers(List<User> entries) async {
    batch(
      (batch) => batch.insertAll(
        users,
        entries,
        mode: InsertMode.replace,
      ),
    );
  }

  Future<List<User>> getUsers() async {
    return select(users).get();
  }

  Future updatePassword(User user) async {
    (update(users)..where((tbl) => tbl.id.equals(user.id))).write(user);
  }

  Future<User?> getLoggedInUser() async {
    return (select(users)..where((tbl) => tbl.isUserLoggedIn))
        .getSingleOrNull();
  }

  Future logOutUser(User user) async {
    (update(users)..where((tbl) => tbl.id.equals(user.id))).write(user);
  }
}

class Users extends Table {
  TextColumn get id => text().nullable()();
  TextColumn get name => text()();
  TextColumn get userName => text()();
  TextColumn get password => text()();
  TextColumn get email => text()();
  TextColumn get street => text()();
  TextColumn get city => text()();
  TextColumn get suite => text()();
  TextColumn get zipCode => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get companyName => text()();
  TextColumn get website => text()();
  BoolColumn get isUserLoggedIn =>
      boolean().withDefault(const Constant(false))();
}
