import '/exports/exports.dart';

class TitleController extends Cubit<String> {
  TitleController() : super(_title);
  static const String _title = "Login";
  void setTitle(String title, String role) {
    if (role.trim() == "Admin") {
      SharedPreferences.getInstance().then((value) {
        value.setString('title', title);
      });
    } else if (role.trim() == "Finance") {
      SharedPreferences.getInstance().then((value) {
        value.setString('finance_title', title);
      });
    } else if (role.trim() == "guest") {
      SharedPreferences.getInstance().then((value) {
        value.setString("guest_title", title);
      });
    }
    emit(title);
  }

  void showTitle(String role) {
    if (role.trim() == "Admin") {
      SharedPreferences.getInstance().then((value) {
        String? title = value.getString('title');
        emit(title ?? "Login");
      });
    } else if (role.trim() == "Finance") {
      SharedPreferences.getInstance().then((value) {
        String? title = value.getString('finance_title');
        emit(title ?? "Login");
      });
    } else if (role.trim() == "guest") {
      SharedPreferences.getInstance().then((value) {
        String? title = value.getString("guest_title");
        emit(title ?? "Login");
      });
    } else {
      emit("Login");
    }
  }
}
