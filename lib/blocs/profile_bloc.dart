import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/repository/login_repository.dart';
import 'package:rxdart/subjects.dart';

class ProfileBloc {
  final userDetails = BehaviorSubject<User>();
  final isUserLoggedOut = BehaviorSubject<bool>();
  final LoginRepository repository;
  ProfileBloc({
    required this.repository,
  }) {
    initDetails();
  }
  Future initDetails() async {
    final user = await repository.getLoggedInUser();
    if (user != null) {
      userDetails.add(user);
    }
  }

  Future logOut() async {
    await repository.logOut();
    isUserLoggedOut.add(true);
  }

  void dispose() {
    userDetails.close();
    isUserLoggedOut.close();
  }
}
