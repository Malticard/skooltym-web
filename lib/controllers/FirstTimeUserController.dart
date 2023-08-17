import 'dart:developer';

import '/exports/exports.dart';

class FirstTimeUserController extends Cubit<bool> {
  FirstTimeUserController() : super(_fuser);
  static bool _fuser = true;
  void setFirstTimeUser(bool checker, String role) {
    if (role.trim() == 'Admin') {
      SharedPreferences.getInstance().then((value) {
        value
            .setBool('firstTimeUser', checker)
            .then((value) => log("Done setting for admin"));

        emit(checker);
      });
    } else {
      SharedPreferences.getInstance().then((value) {
        value
            .setBool('financeFirstTimeUser', checker)
            .then((value) => log("Done setting for finance"));

        emit(checker);
      });
    }
  }

  // retrieve saved state
  void getFirstTimeUser(String role) {
    if (role.trim() == 'Admin') {
      SharedPreferences.getInstance().then((value) {
        log("first time user ${value.getBool('firstTimeUser')}");
        emit(value.getBool('firstTimeUser') ?? true);
      });
    } else {
      SharedPreferences.getInstance().then((value) {
        emit(value.getBool('financeFirstTimeUser') ?? true);
      });
    }
  }
}
