import '../exports/exports.dart';

class SideBarController extends Cubit<int>{
  SideBarController() : super(10);
  void changeSelected(int index) => emit(index);
}