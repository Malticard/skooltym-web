import '/exports/exports.dart';

class IntervalController extends Cubit<int> {
  IntervalController() : super(index);
  static int index = 0;

  computeInterval(int v){
    SharedPreferences.getInstance().then((value) {
      value.setInt("interval", v);
    });
    emit(v);
  }
  getComputedInterval(){
    SharedPreferences.getInstance().then((value) {
      emit(value.getInt("interval") ?? 0);
    });
  }
}
