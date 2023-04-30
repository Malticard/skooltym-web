import '/exports/exports.dart';

class FinanceTitleController extends Cubit<String> {
  FinanceTitleController() : super(_title);
  static const String _title = "ChangePassword";
  void setTitle(String title) => emit(title);
}
