import '/exports/exports.dart';

class MainController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _dashData = [];
  List<StudentModel> _students = [];
  List<DropOffModel> _drops = [];
  List<PickUpModel> _picks = [];
  List<Guardians> _guardians = [];
  List<StaffModel> _availableStaff = [];
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<Map<String, dynamic>> get dashboardData => _dashData;

// getters
  List<StudentModel> get students => _students;
  List<StaffModel> get staffData => _availableStaff;
  List<Guardians> get guardians => _guardians;
  List<DropOffModel> get dropOffData => _drops;
  List<PickUpModel> get pickUpData => _picks;

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

// check for new entries of students
  void staffUpdate() {
    Client().get(Uri.parse(AppUrls.staff)).then((response) {
      _availableStaff = staffModelFromJson(response.body);
      notifyListeners();
    });
  }

  // check new guardians
  void newGuardians() {
    Client().get(Uri.parse(AppUrls.getGuardians)).then((value) {
      _guardians = guardiansFromJson(value.body);
      notifyListeners();
    });
  }

  // available picks and drops
  availableDropOffs() {
    dropOffs().then((drops) {
      _drops = drops;
      notifyListeners();
    });
  }

  availablePickUps() {
    pickUps().then((picks) {
      _picks = picks;
      notifyListeners();
    });
  }
}
