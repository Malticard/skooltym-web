import '../exports/exports.dart';

class SchoolController extends Cubit<Map<String, dynamic>> {
  SchoolController() : super(initialData);
  static Map<String, dynamic> initialData = {};
  void setSchoolData(Map<String, dynamic> data) => emit(data);
}
