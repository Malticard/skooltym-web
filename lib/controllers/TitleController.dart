import '/exports/exports.dart';

class TitleController extends Cubit<String> {
  TitleController() : super(_title);
  static const String _title = "Login";
  void setTitle(String title) {
    SharedPreferences.getInstance().then((value) {
      String? s = value.getString("schoolData");
      if (s != null) {
        String role = json.decode(s)['role'];
        if (role.trim() == "Admin") {
          value.setString('title', title);
        } else if (role.trim() == "Finance") {
          value.setString('finance_title', title);
        } else if (role.trim() == "guest") {
          value.setString("guest_title", title);
        }
      }
    });
    emit(title);
  }

  void showTitle() {
    SharedPreferences.getInstance().then((value) {
      String? s = value.getString("schoolData");
      if (s != null) {
        String role = json.decode(s)['role'];
        if (role.trim() == "Admin") {
          String? title = value.getString('title');
          emit(title ?? "Login");
        } else if (role.trim() == "Finance") {
          String? title = value.getString('finance_title');
          emit(title ?? "Login");
        } else if (role.trim() == "guest") {
          String? title = value.getString("guest_title");
          emit(title ?? "Login");
        } else {
          emit("Login");
        }
      }
    });
  }
}
