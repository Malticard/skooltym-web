import '/exports/exports.dart';
class DropOffController extends Cubit<List<DropOffModel>>{
  DropOffController() : super([]);
  getDropOff(BuildContext ctx){
    Client().get(Uri.parse(AppUrls.getDropOffs + ctx.read<SchoolController>().state['school'] )).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        emit(dropOffModelFromJson(value.body));
      }
    });
  }
}