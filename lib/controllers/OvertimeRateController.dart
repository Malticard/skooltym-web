import '/exports/exports.dart';

class OvertimeRateController extends Cubit<int> {
  OvertimeRateController() : super(rate);
  static int rate = 0;
  void setOvertimeRate(int d) {
    // SharedPreferences.getInstance().then((value) {
    //   value.setInt("overtime_rate", d);
    // });
    emit(d);
  }

  getOvertimeRate() {
    // SharedPreferences.getInstance().then((value) {
    //   emit(value.getInt("overtime_rate") ?? 0);
    // });
    emit(state);
  }
}
