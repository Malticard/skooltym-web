import 'dart:developer';

import '/exports/exports.dart';

class FirstTimeUserController extends Cubit<bool> {
  FirstTimeUserController() : super(_fuser);
  static bool _fuser = true;
  void setFirstTimeUser(bool checker) {
    SharedPreferences.getInstance().then((value) {
      String? s = value.getString("schoolData");
      if (s != null) {
        String role = json.decode(s)['role'];
        if (role == 'Admin') {
          value
              .setBool('firstTimeUser', checker)
              .then((value) => log("Done setting for admin"));

          emit(checker);
        } else {
          value
              .setBool('financeFirstTimeUser', checker)
              .then((value) => log("Done setting for finance"));

          emit(checker);
        }
      }
    });
  }

  // retrieve saved state
  void getFirstTimeUser() {
    SharedPreferences.getInstance().then((value) {
      String? s = value.getString("schoolData");
      if (s != null) {
        String role = json.decode(s)['role'];
        if (role == 'Admin') {
          emit(value.getBool('firstTimeUser') ?? true);
        } else {
          emit(value.getBool('financeFirstTimeUser') ?? true);
        }
      }
    });
  }
}
