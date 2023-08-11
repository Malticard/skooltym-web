import '/exports/exports.dart';

class FinanceViewController extends Cubit<Widget> {
  FinanceViewController() : super(object);
  static Widget object = const ChangePassword();
  static List<Widget> pages = [
    const Dashboard(),
    const ClearedOvertime(),
    const PendingOvertime(),
    const ChangePassword(),
  ];
  void pushWidget(int page) {
    SharedPreferences.getInstance().then((value) {
      value.setInt('finance_page', page);
    });
    emit(pages[page]);
  }

  // Widget fetchWidget(String role) => role == 'Finance'? state;
  void showRecentWidget() {
    SharedPreferences.getInstance().then((value) {
      int? role = value.getInt('finance_page');
      emit(pages[role ?? 3]);
    });
  }
}
