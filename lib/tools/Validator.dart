// ignore_for_file: unnecessary_null_comparison, camel_case_types

class Validator_ {
  static const String _pattern =
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";
  // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static final RegExp _regex = RegExp(_pattern);

  static bool validateEmail(String value) {
    return _regex.hasMatch(value);
  }

  static bool isValidNumber(String input) {
  if (input == null) {
    return false;
  }
  final numberRegex = RegExp(r'^\d*\.?\d+$');
  return numberRegex.hasMatch(input);
}
}