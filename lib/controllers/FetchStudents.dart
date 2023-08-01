import '../models/StudentModel.dart';
import '/exports/exports.dart';
class FetchStudentsController extends Cubit<List<Student>>{
  FetchStudentsController():super([]);
  getStudents(String school){
    fetchStudents(school).then((value) {
      emit(value.results);
    });
  }
}