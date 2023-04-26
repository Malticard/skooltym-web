import '/exports/exports.dart';

class MultiStudentsController extends Cubit<String>{
  MultiStudentsController():super("");
  void setMultiStudents(String map){
    SharedPreferences.getInstance().then((value) {
      value.setString('multiStudents', map);
    });
    emit(map);
  }
  void getMultiStudents(){
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey('multiStudents')) {
        emit(value.getString('multiStudents')!);
        if (kDebugMode) {
          print("Attached students => ${value.getString('multiStudents')!}");
        }
      }
    });
  }
}