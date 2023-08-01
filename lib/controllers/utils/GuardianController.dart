import '../../models/Guardians.dart';
import '/exports/exports.dart';
class GuardianController extends Cubit<List<Guardian>>{
  GuardianController() : super([]);
  getGuardians(BuildContext ctx){
    Client().get(Uri.parse(AppUrls.getGuardians + ctx.read<SchoolController>().state['school']+"?page=1&pageSize=100")).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        emit(gaurdiansFromJson(value.body).results);
      }
    });
  }
}