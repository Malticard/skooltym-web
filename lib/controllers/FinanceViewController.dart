import '/exports/exports.dart';

class FinanceViewController extends Cubit<Widget>{
  FinanceViewController() : super(object);
  static Widget object = const ChangePassword();
  void pushWidget(Widget widget) => emit(widget);
}