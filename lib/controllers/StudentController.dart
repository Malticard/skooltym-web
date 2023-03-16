import '/exports/exports.dart';

class StudentController extends Cubit<String> {
  StudentController() : super(text);
  //
  static String text = '';
  void trackStudent(String student) => emit(student);
}
