import '/exports/exports.dart';

class PickUpTimeController extends Cubit<String> {
  PickUpTimeController() : super(time);
  static const String time = "";
  setPickUpTime(String time) {
    // SharedPreferences.getInstance().then(
    //   (value) {
    //     value.setString("pick_up_time", time);
    //   },
    // );
    emit(time);
  }

  getPickUpTime() {
    //  SharedPreferences.getInstance().then(
    //   (value) {
    //     emit(value.getString("pick_up_time") ?? "");
    //   }
    // );
    emit(state);
  }
}
