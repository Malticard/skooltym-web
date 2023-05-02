import '/exports/exports.dart';
class ClassController extends Cubit<List<ClassModel>>{
  ClassController() : super([]);
  getClasses(BuildContext ctx){
    Client().get(Uri.parse(AppUrls.getClasses + ctx.read<SchoolController>().state['school'])).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        emit(classModelFromJson(value.body));
      }
    });
  }
}