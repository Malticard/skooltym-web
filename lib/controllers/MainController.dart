import '/exports/exports.dart';

class MainController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _dashData = [];
  List<StudentModel> _students = [];
  List<DropOffModel> _drops = [];
  List<PickUpModel> _picks = [];
  List<Guardians> _guardians = [];
  List<StaffModel> _availableStaff = [];
  int _stepCount = 0;
  List<dynamic> _multiselect = [];
  List<OvertimeModel> _pendingOvertime = [];
// getters
  List<StudentModel> get students => _students;
  List<StaffModel> get staffData => _availableStaff;
  List<Guardians> get guardians => _guardians;
  List<DropOffModel> get dropOffData => _drops;
  int get stepCount => _stepCount;
  List<PickUpModel> get pickUpData => _picks;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<Map<String, dynamic>> get dashboardData => _dashData;
  List<OvertimeModel> get pendingOvertime => _pendingOvertime;
  List<dynamic> get multiselect => _multiselect;
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
//  fetch pending overtimes
void fetchPendingOvertime(String status){
  Client().get(Uri.parse(AppUrls.specficOvertime + status)).then((value) {
    _pendingOvertime = overtimeModelFromJson(value.body);
    notifyListeners();
  });
}
// stepper text count
void setTextCount(int value){
    _stepCount = value;
    notifyListeners();
}
//
void newSelection(List<dynamic> selection){
    _multiselect = selection;
    notifyListeners();
}
}
