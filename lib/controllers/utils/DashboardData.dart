import '/exports/exports.dart';

class DashboardDataController extends Cubit<List<DashboardModel>>{
  DashboardDataController():super([]);
  getDashBoardData(String school){
      Client().get(Uri.parse(AppUrls.dashboard + school)).then((value) {
        if (value.statusCode == 200) {
          emit(dashboardModelFromJson(value.body));
        }
      });
  }
}