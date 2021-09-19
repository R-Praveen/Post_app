Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

String passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp regExp = RegExp(pattern.toString());
RegExp regExpPassword = RegExp(passwordPattern);

/*Checks for proper email is entered using the regex and allows 
for eg in this format test@gmail.com
and rejects asd.com, asd@de , asdsa..
*/
bool validateEmailIsValid(String email) {
  return regExp.hasMatch(email);
}

/*Checks for 1 uppercase, 1 lowercase, 1 numeric character,
 1 special character, and 8 minimum character length
 */
bool validatePasswordIsValid(String password) {
  return regExpPassword.hasMatch(password);
}
