import '../exports/exports.dart';

class ClockInClockOutController extends Cubit<bool> {
  ClockInClockOutController() : super(allow);
  static bool allow = false;

  void allow_clock_in_clock_out(bool clock_in_clock_out) {
    // SharedPreferences.getInstance().then((value) {
    //   value.setBool("clock_in_clock_out", clock_in_clock_out);
    // });
    emit(clock_in_clock_out);
  }

  void get_allow_clock_in_clock_out() {
    emit(state);
    // SharedPreferences.getInstance().then((value) {
    //   emit(value.getBool("clock_in_clock_out") ?? false);
    // });
  }
}
