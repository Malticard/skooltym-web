import '/exports/exports.dart';

class MainController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _dashData = [];
  List<Students> _students = [];
  List<StaffModel> _availableStaff = [];
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<Map<String, dynamic>> get dashboardData => _dashData;

  List<Students> get students => _students;
  List<StaffModel> get staffData => _availableStaff;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
    // function to fetch updates for the dashboard

    // set dashData
  }

  void fetchUpdates(BuildContext context) {
    fetchDashboardMetaData(context).then((v) {
      _dashData = v;
      notifyListeners();
    });
  }

  // getting available students
  void getAllStudents() {
    fetchStudents().then((v) {
      _students = v;
      notifyListeners();
    });
  }

  void staffUpdate() {
    Client().get(Uri.parse(AppUrls.staff)).then((response) {
      _availableStaff = staffModelFromJson(response.body);
      notifyListeners();
    });
  }
}
