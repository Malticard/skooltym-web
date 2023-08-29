import '../exports/exports.dart';

class SchoolController extends Cubit<Map<String, dynamic>> {
  SchoolController() : super(initialData);
  static Map<String, dynamic> initialData = {};

  // method to save school data from shared preferences
  void setSchoolData(Map<String, dynamic> data) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('schoolData', jsonEncode(data));
    });
    // save details to shared preferences
    emit(data);
  }

  // method to get school data from shared preferences
  void getSchoolData() {
    SharedPreferences.getInstance().then((prefs) {
      String? t = prefs.getString('schoolData');
      if (prefs.containsKey('schoolData') && t != null) {
        emit(jsonDecode(t));
      }
    });
  }

  //
  logout() {
    SharedPreferences.getInstance().then(
      (value) => value.remove("schoolData"),
    );
  }
}
