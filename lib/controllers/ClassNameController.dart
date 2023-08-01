import '/exports/exports.dart';

class ClassNameController extends Cubit<List<String>>{
  ClassNameController():super(i);
  static List<String> i = [];
  void setClass(String className){
    SharedPreferences.getInstance().then((prefs) {
      json.decode(prefs.getString("classes")!).forEach((value) {
        if(value.className == className){
          emit(value.classStreams);
        }
      });
    });
  }
}