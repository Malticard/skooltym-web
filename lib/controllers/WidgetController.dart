import 'package:skooltym_admin/exports/exports.dart';

class WidgetController extends Cubit<Widget> {
  WidgetController() : super(object);
  static Widget object = const Center();
  void pushWidget(Widget widget) => emit(widget);
}
