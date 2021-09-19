import 'package:flutter/foundation.dart';
import 'package:posts_app/helpers/exceptions.dart';
import 'package:posts_app/helpers/validations.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/local_database/users_database.dart';
import 'package:posts_app/models/login_model.dart';
import 'package:posts_app/services/login_services.dart';

class LoginRepository {
  final LoginServices services;
  final UsersDao usersDao;
  LoginRepository({
    required this.services,
    required this.usersDao,
  });

  //Fetching users details from database and storing in local
  Future fetchUsers() async {
    try {
      final List<User> users = [];
      final usersDao = await getUsers();
      if (usersDao?.isEmpty ?? true) {
        final usersData = await services.fetchUsers();
        for (final user in usersData) {
          users.add(
            User(
              id: user["id"].toString(),
              name: user["name"] ?? '',
              userName: user["username"] ?? '',
              password: '',
              email: user["email"] ?? '',
              street: user["address"]["street"] ?? '',
              city: user["address"]["city"] ?? '',
              suite: user["address"]["suite"] ?? '',
              zipCode: user["address"]["zipcode"] ?? '',
              phoneNumber: user["phone"],
              website: user["website"],
              companyName: user["company"]["name"] ?? '',
              isUserLoggedIn: false,
            ),
          );
        }
        await saveUsers(users);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getUsers() async {
    return usersDao.getUsers();
  }

  Future saveUsers(List<User> users) async {
    usersDao.saveUsers(users);
  }

  Future<User?> getLoggedInUser() async {
    return usersDao.getLoggedInUser();
  }

  Future<bool> isUserLoggedIn() async {
    final user = await usersDao.getLoggedInUser();
    return user?.isUserLoggedIn ?? false;
  }

  Future login(LoginModel loginModel) async {
    final users = await usersDao.getUsers();

    //Checks email exists in the local database and throws exception if does not exist
    if (!checkEmailExists(users, loginModel)) {
      throw EmailDoesNotExistException();
    }
  }

  Future updatePassword(User user, String password) async {
    await usersDao.updatePassword(
      user.copyWith(
        password: password,
        isUserLoggedIn: true,
      ),
    );
  }

  /*Checking the email by converting to lowercase and if it matches 
  then proceeding to check for passwor dvalidation
  */
  bool checkEmailExists(List<User> users, LoginModel loginModel) {
    bool _isValid = false;
    for (final user in users) {
      if (loginModel.emailId.toLowerCase() == user.email.toLowerCase()) {
        _isValid = true;
        final passwordValidated = validatePassword(user, loginModel.password);
        if (passwordValidated) {
          updatePassword(user, loginModel.password);
        }
        break;
      }
    }
    return _isValid;
  }

  /*
  Checking password is in correct format and if password is in correct format
   checks for already save password matches with the one user entered 
   and if database passaword is empty then updating the user password in database
    for checking for future use
    */
  bool validatePassword(User user, String newPassword) {
    bool _isValid = false;
    if (validatePasswordIsValid(newPassword)) {
      if (user.password.isEmpty) {
        _isValid = true;
      } else {
        if (user.password != newPassword) {
          throw PassWordMisMatchException();
        } else {
          _isValid = true;
        }
      }
    }
    return _isValid;
  }

  //logging out the user from the app
  Future logOut() async {
    try {
      final user = await getLoggedInUser();
      await usersDao.logOutUser(
        user!.copyWith(isUserLoggedIn: false),
      );

      //Clearing all user related tables from local after log out
      await AppDatabase.instance().clearUserRelatedTables();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
