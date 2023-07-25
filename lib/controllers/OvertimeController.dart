
import '../models/OvertimeModel.dart';
import '/exports/exports.dart';

class OvertimeController extends Cubit<List<OvertimeModel>> {
  OvertimeController() : super([]);
  // static OvertimeReports _overtime = OvertimeReports();
  // fetch available overtime
  void fetchOvertime() async {
    Client().get(Uri.parse(AppUrls.overtime)).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        if (data['status'] == 'success') {
          emit(overtimeModelFromJson(value.body));
        }
      }
    });
    // emit(OvertimeReports());
  }
}
