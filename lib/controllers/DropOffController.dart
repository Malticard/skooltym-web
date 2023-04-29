import '/exports/exports.dart';

class DropOffAllowanceController extends Cubit<double> {
  DropOffAllowanceController() : super(_time);
  static final double _time = 0;
  setDropOffAllowanceTime(double time) {
    SharedPreferences.getInstance().then(
      (value) {
        value.setDouble("drop_off_time_allowance", time);
      },
    );
    emit(time);
  }
  getDropOffAllowance(){
     SharedPreferences.getInstance().then(
      (value) {
        emit(value.getDouble("drop_off_time_allowance") ?? 0.0);
      }
    );
  }
}
