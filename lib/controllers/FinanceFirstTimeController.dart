import '/exports/exports.dart';

class FinanceFirstTimeController extends Cubit<bool>{
  FinanceFirstTimeController() : super(true);
  void setFirstTime(bool checker) {
    SharedPreferences.getInstance().then((value) {
      value.setBool('firstTime',checker );
    });
    emit(checker);
  }
  // retrive saved state
  void getFirstTime() {
    SharedPreferences.getInstance().then((value) {
      emit(value.getBool('firstTime') ?? true);
    });
  }
}