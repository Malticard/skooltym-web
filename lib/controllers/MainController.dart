// ignore_for_file: unrelated_type_equality_checks
import '/exports/exports.dart';

class MainController with ChangeNotifier {
  /// half day configurations
  double _halfDayPickUpAllowance = 0.0;
  String _pick_up_start_time_half_day = "";
  String _pick_up_end_time_half_day = "";
  // getters
  double get halfDayPickUpAllowance {
    _getHalfDayPickUpAllowance();
    return _halfDayPickUpAllowance;
  }

  String get pick_up_start_time_half_day {
    _getPickUpStartTimeHalfDay();
    return _pick_up_start_time_half_day;
  }

  String get pick_up_end_time_half_day {
    _getPickUpEndTimeHalfDay();
    return _pick_up_end_time_half_day;
  }
  // end of getters

// setters
  set setHalfDayPickUpAllowance(double pickUpAllowance) {
    SharedPreferences.getInstance().then((value) {
      value.setDouble('halfDayPickUpAllowance', pickUpAllowance);
    });
    _halfDayPickUpAllowance = pickUpAllowance;
    notifyListeners();
  }

  // timestamps for half day pickups
  set setPickUpStartTimeHalfDay(String pickUpStartTime) {
    SharedPreferences.getInstance().then((value) {
      value.setString('pick_up_start_time_half_day', pickUpStartTime);
    });
    _pick_up_start_time_half_day = pickUpStartTime;
    notifyListeners();
  }

  set setPickUpEndTimeHalfDay(String pickUpEndTime) {
    SharedPreferences.getInstance().then((value) {
      value.setString('pick_up_end_time_half_day', pickUpEndTime);
    });
    _pick_up_end_time_half_day = pickUpEndTime;
    notifyListeners();
  }
// -------------------------------------------------------------------------

// retrieve saved values
  void _getHalfDayPickUpAllowance() {
    SharedPreferences.getInstance().then((value) {
      _halfDayPickUpAllowance =
          value.getDouble('halfDayPickUpAllowance') ?? 0.0;
      notifyListeners();
    });
  }

  //
  void _getPickUpStartTimeHalfDay() {
    SharedPreferences.getInstance().then((value) {
      _pick_up_start_time_half_day =
          value.getString('pick_up_start_time_half_day') ?? "";
      notifyListeners();
    });
  }

  void _getPickUpEndTimeHalfDay() {
    SharedPreferences.getInstance().then((value) {
      _pick_up_end_time_half_day =
          value.getString('pick_up_end_time_half_day') ?? "";
      notifyListeners();
    });
  }

  /// pick up time
}
