import '/exports/exports.dart';

class WidgetController extends Cubit<Widget> {
  WidgetController() : super(object);
  static Widget object = const SystemSettings();
  void pushWidget(Widget widget) => emit(widget);
  // Widget fetchWidget(String role) => role == 'Finance'? state;
}
