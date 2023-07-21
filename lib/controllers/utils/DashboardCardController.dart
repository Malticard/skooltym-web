import '/exports/exports.dart';
class DashboardCardsController extends Cubit<List<Map<String, dynamic>>>{
  DashboardCardsController() : super([]);
  void fetchUpdates(BuildContext context){
     fetchDashboardMetaData(context).then((v) {
       emit(v);
      });
  }
}