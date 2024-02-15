import '/exports/exports.dart';

class PickUpAllowanceTimeController extends Cubit<int> {
  PickUpAllowanceTimeController() : super(_time);
  static int _time = 0;
  void setPickUpAllowanceTime(int time) {
    // SharedPreferences.getInstance().then((value) {
    //   value.setInt("pick_up_time_allowance", time);
    // });
    emit(time);
  }

  void getComputedPickUpTime() {
    // SharedPreferences.getInstance().then((value) {
    //   emit(value.getInt("pick_up_time_allowance") ?? 0);
    // });
    emit(state);
  }
}
