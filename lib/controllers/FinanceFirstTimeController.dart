import 'package:skool_web/exports/exports.dart';

class FinanceFirstTimeController extends Cubit<bool>{
  FinanceFirstTimeController() : super(true);
  void setFirstTime(bool checker) {
    SharedPreferences.getInstance().then((value) {
      value.setBool('firstTime',checker );
    });
    emit(checker);
  }
  // retive saved state
  void getFirstTime() {
    SharedPreferences.getInstance().then((value) {
      emit(value.getBool('firstTime') ?? true);
    });
  }
}