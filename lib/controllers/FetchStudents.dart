import '/exports/exports.dart';
class FetchStudentsController extends Cubit<List<StudentModel>>{
  FetchStudentsController():super([]);
  getStudents(String school){
    fetchStudents(school).then((value) {
      emit(value);
    });
  }
}