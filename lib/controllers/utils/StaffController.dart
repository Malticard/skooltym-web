import '/exports/exports.dart';
class StaffController extends Cubit<List<StaffModel>>{
  StaffController() : super([]);
  getStaffs(BuildContext ctx){
    Client().get(Uri.parse(AppUrls.staff+ ctx.read<SchoolController>().state['school'])).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        emit(staffModelFromJson(value.body));
      }
    });
  }
}