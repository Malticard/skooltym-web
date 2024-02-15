// import '../models/StudentModel.dart';
import '../models/students_not_paginated_model.dart';
import '/exports/exports.dart';

class FetchStudentsController extends Cubit<List<StudentsNotPaginatedModel>> {
  FetchStudentsController() : super([]);
  getStudents(String school) {
    fetchStudents(school).then((value) {
      emit(value);
    });
  }
}
