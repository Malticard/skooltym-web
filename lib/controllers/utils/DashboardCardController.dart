import '/exports/exports.dart';
class DashboardCardsController extends Cubit<List<Map<String, dynamic>>>{
  DashboardCardsController() : super([]);
  void fetchUpdates(String school, String role){
     fetchDashboardMetaData(school, role).then((v) {
       emit(v);
      });
  }
}