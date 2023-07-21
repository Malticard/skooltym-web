import '../exports/exports.dart';

class AllowOvertimeController extends Cubit<bool> {
  AllowOvertimeController() : super(allow);
  static bool allow = false;

  allowOvertime(bool overtime){
    SharedPreferences.getInstance().then((value) {
      value.setBool("allow_overtime", overtime);
    });
    emit(overtime);
  }
  getAllowOvertime(){
    SharedPreferences.getInstance().then((value) {
      emit(value.getBool("allow_overtime") ?? false);
    });
  }
}
