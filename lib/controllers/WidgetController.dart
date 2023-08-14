import '/exports/exports.dart';

class WidgetController extends Cubit<Widget> {
  WidgetController() : super(object);
  static Widget object = const ChangePassword();

  static List<Widget> pages = [
    const Dashboard(),
    const ViewStudents(),
    const StaffView(),
    const ViewGuardians(),
    const ClassesUI(),
    const StreamsUI(),
    const PendingOvertime(),
    const ClearedOvertime(),
    const ViewDropOffs(),
    const ViewPickUps(),
    const ChangePassword(),
    const SystemSettings(),
  ];
  void pushWidget(int page) {
    SharedPreferences.getInstance().then((value) {
      value.setInt('page', page);
    });
    emit(pages[page]);
  }

  // Widget fetchWidget(String role) => role == 'Finance'? state;
  void showRecentWidget() {
    SharedPreferences.getInstance().then((value) {
      int? role = value.getInt('page');
      emit(pages[role ?? 10]);
    });
  }
}
