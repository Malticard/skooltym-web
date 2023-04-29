import 'package:skool_web/exports/exports.dart';

class FirstTimeUserController extends Cubit<bool>{
  FirstTimeUserController() : super(false);
  void setFirstTimeUser(bool value) {
    SharedPreferences.getInstance().then((value) {
      value.setBool('firstTimeUser', value.getBool('firstTimeUser') ?? false);
    });
    emit(value);
  }
  // retive saved state
  void getFirstTimeUser() {
    SharedPreferences.getInstance().then((value) {
      emit(value.getBool('firstTimeUser') ?? false);
    });
  }
}