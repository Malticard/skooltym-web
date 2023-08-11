import '../exports/exports.dart';

class SideBarController extends Cubit<int> {
  SideBarController() : super(_page);
  static int _page = 10;
  void changeSelected(int index, String role) {
    if (role == "Admin") {
      SharedPreferences.getInstance().then((value) {
        value.setInt('page', index);
      });
      emit(index);
    } else if (role == "Finance") {
      SharedPreferences.getInstance().then((value) {
        value.setInt('finance_page', index);
      });
      emit(index);
    }
  }

  void showCurrentSelection(String role) {
    if (role == "Admin") {
      SharedPreferences.getInstance().then((value) {
        int? x = value.getInt('page');
        emit(x ?? 0);
      });
    } else {
      SharedPreferences.getInstance().then((value) {
        int? x = value.getInt('finance_page');
        emit(x ?? 0);
      });
    }
  }
}
