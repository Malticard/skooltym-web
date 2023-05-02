import '/exports/exports.dart';
class GuardianController extends Cubit<List<Guardians>>{
  GuardianController() : super([]);
  getGuardians(BuildContext ctx){
    Client().get(Uri.parse(AppUrls.getGuardians + ctx.read<SchoolController>().state['school'])).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        emit(guardiansFromJson(value.body));
      }
    });
  }
}