import 'package:skool_web/exports/exports.dart';

class FirstTimeUserController extends Cubit<bool>{
  FirstTimeUserController() : super(true);
  void setFirstTimeUser(bool checker) {
    SharedPreferences.getInstance().then((value) {
      value.setBool('firstTimeUser',checker );
    });
    emit(checker);
  }
  // retive saved state
  void getFirstTimeUser() {
    SharedPreferences.getInstance().then((value) {
      emit(value.getBool('firstTimeUser') ?? true);
    });
  }
}