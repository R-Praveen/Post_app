import 'package:posts_app/helpers/exceptions.dart';
import 'package:posts_app/helpers/validations.dart';
import 'package:posts_app/models/login_model.dart';
import 'package:posts_app/repository/login_repository.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc {
  final LoginRepository loginRepository;

  //Fields
  final email = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();

  final loginUser = BehaviorSubject<bool>();
  final checkUserLoggedIn = BehaviorSubject<bool>();
  //Errors
  final emailError = BehaviorSubject<String>();
  final passwordError = BehaviorSubject<String>();
  LoginBloc({
    required this.loginRepository,
  }) {
    initDetails();
  }
  Future initDetails() async {
    await loginRepository.fetchUsers();
    final isUserLoggedIn = await loginRepository.isUserLoggedIn();
    checkUserLoggedIn.add(isUserLoggedIn);
  }

  void onEmailChanged(String value) async {
    email.add(value);
    validateEmail(value);
  }

  bool validateEmail(String? value) {
    bool _isValid = true;
    if (value?.isEmpty ?? true) {
      emailError.add("Please enter the email address");
      _isValid = false;
    } else if (!validateEmailIsValid(value ?? '')) {
      emailError.add("Please enter the valid email address");
      _isValid = false;
    } else {
      emailError.add('');
    }
    return _isValid;
  }

  void onPasswordChanged(String value) async {
    password.add(value);
    validatePassword(value);
  }

  bool validatePassword(String? value) {
    bool _isValid = true;
    if (value?.isEmpty ?? true) {
      passwordError.add("Please enter the pasword");
      _isValid = false;
    } else if (!validatePasswordIsValid(value ?? '')) {
      passwordError.add(
          "Please enter the password with 1 uppercase, 1 number, atleast 8 characters");
      _isValid = false;
    } else {
      passwordError.add('');
    }
    return _isValid;
  }

  Future onClickContinue() async {
    try {
      bool _isValid = true;
      _isValid = validateEmail(email.valueOrNull);
      _isValid = validatePassword(password.valueOrNull);
      if (_isValid) {
        await loginRepository.login(
          LoginModel(
            emailId: email.value,
            password: password.value,
          ),
        );
      }
      loginUser.add(true);
    } catch (e) {
      if (e is EmailDoesNotExistException) {
        emailError.add("Please enter from the email list");
      }
      if (e is PassWordMisMatchException) {
        passwordError
            .add("Passwords does not match with already saved password");
      }
    }
  }

  void dispose() {
    email.close();
    password.close();
    emailError.close();
    passwordError.close();
    loginUser.close();
    checkUserLoggedIn.close();
  }
}
