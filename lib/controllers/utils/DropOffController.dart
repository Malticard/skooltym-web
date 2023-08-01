import '../../models/DropOffModels.dart';
import '/exports/exports.dart';
class DropOffController extends Cubit<List<DropOff>>{
  DropOffController() : super([]);
  void getDropOff(BuildContext ctx){
    Client().get(Uri.parse(AppUrls.getDropOffs + ctx.read<SchoolController>().state['school']+"?page=1&pageSize=100" )).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        emit(dropOffModelFromJson(value.body).results);
      }
    });
  }
}