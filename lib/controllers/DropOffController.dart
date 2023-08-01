import '/exports/exports.dart';

class DropOffAllowanceController extends Cubit<int> {
  DropOffAllowanceController() : super(_time);
  static final int _time = 0;
  setDropOffAllowanceTime(int time) {
    SharedPreferences.getInstance().then(
      (value) {
        value.setInt("drop_off_time_allowance", time);
      },
    );
    emit(time);
  }
  getDropOffAllowance(){
     SharedPreferences.getInstance().then(
      (value) {
        emit(value.getInt("drop_off_time_allowance") ?? 0);
      }
    );
  }
}
