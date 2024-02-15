import '/exports/exports.dart';

class DropOffTimeController extends Cubit<String> {
  DropOffTimeController() : super(time);
  static const String time = "";
  setDropOffTime(String time) {
    // SharedPreferences.getInstance().then(
    //   (value) {
    //     value.setString("drop_off_time", time);
    //   }
    // );
    emit(time);
  }

  getDropOffTime() {
    emit(state);
    // SharedPreferences.getInstance().then(
    //   (value) {
    //     emit(value.getString("drop_off_time") ?? "");
    //   }
    // );
  }
}
