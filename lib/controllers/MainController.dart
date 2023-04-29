// ignore_for_file: unrelated_type_equality_checks

import '/exports/exports.dart';

class MainController extends ChangeNotifier {
  List<Map<String, dynamic>> _dashData = [];
  List<StudentModel> _students = [];
  List<DropOffModel> _drops = [];
  List<PickUpModel> _picks = [];
  List<Guardians> _guardians = [];
  List<StaffModel> _availableStaff = [];
  List<StreamModel> _streams = [];
  List<DashboardModel> _dashboardClasses = [];
  // searching arrays
  List<StaffModel> _searchStaff = [];
  List<StudentModel> _searchStudent = [];
  List<Guardians> _searchGuardian = [];
  List<DropOffModel> _searchDropOff = [];
  List<PickUpModel> _searchPickUp = [];
  // end of searching arrays
  List<ClassModel> _classes = [];
  int _stepCount = 0;
  List<dynamic> _multiguardian = [];
  List<dynamic> _multistudent = [];
  List<OvertimeModel> _pendingOvertime = [];

// getters
  List<StudentModel> get students => _students;
  List<StaffModel> get staffData => _availableStaff;
  // search getters
  List<StaffModel> get sStaff => _searchStaff;
  List<StudentModel> get sStudent => _searchStudent;
  List<Guardians> get sGuardian => _searchGuardian;
  List<DropOffModel> get sdropOff => _searchDropOff;
  List<PickUpModel> get sPickUp => _searchPickUp;
  List<DashboardModel> get  dashboardClasses => _dashboardClasses;

  // end of search
  List<Guardians> get guardians => _guardians;
  List<DropOffModel> get dropOffData => _drops;
  int get stepCount => _stepCount;
  List<PickUpModel> get pickUpData => _picks;
  // GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<Map<String, dynamic>> get dashboardData => _dashData;
  List<OvertimeModel> get pendingOvertime => _pendingOvertime;
  List<dynamic> get multistudent => _multistudent;
  List<dynamic> get multiguardian => _multiguardian;
  List<ClassModel> get classes => _classes;
  List<StreamModel> get streams => _streams;

  // end of getters

  void controlMenu(GlobalKey<ScaffoldState> scaffoldKey) {
    // if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  void fetchUpdates(String school,String role) {
    fetchDashboardMetaData(school,role).then((v) {
      _dashData = v;
      notifyListeners();
    });
  }

  // getting available students
  void getAllStudents(BuildContext context) {
   Client().get(Uri.parse(AppUrls.students + context.read<SchoolController>().state['school'])).then((v) {
      _students = studentModelFromJson(v.body);
      notifyListeners();
    });
  }

// check for new entries of students
  void staffUpdate(String school) {
    Client().get(Uri.parse(AppUrls.staff + school)).then((response) {
      _availableStaff = staffModelFromJson(response.body);
      notifyListeners();
    });
  }
  // check new guardians
  void newGuardians(BuildContext context) {
    try {
      Client().get(Uri.parse(AppUrls.getGuardians + context.read<SchoolController>().state['school'])).then((value) {
      _guardians = guardiansFromJson(value.body);
      notifyListeners();
    });
    } on ClientException catch (_, e) {
      showMessage(context: context,msg: _.message,type: 'warning');
    }
    
  }

  // available picks and drops
  availableDropOffs(String school) {
    dropOffs(school).then((drops) {
      _drops = drops;
      notifyListeners();
    });
  }

  availablePickUps(String school) {
    pickUps(school).then((picks) {
      // debugPrint("Picks => $picks");
      _picks = picks;
      notifyListeners();
    });
  }
//  fetch pending overtimes
void fetchPendingOvertime(String status, BuildContext context) {
  Client().get(Uri.parse(AppUrls.overtime + context.read<SchoolController>().state['school'])).then((value) {
    // debugPrint("Current overtime response => ${value.body}");
    _pendingOvertime = overtimeModelFromJson((value.body)).where((element) => element.status == status).toList();
    notifyListeners();
  });
}
// stepper text count
void setTextCount(int value){
    _stepCount = value;
    notifyListeners();
}
//
void selectMultiGuardians(List<dynamic> selection){
  // debugPrint("Selection => $selection");
    _multiguardian = selection;
    notifyListeners();
}

void selectMultiStudent(List<dynamic> selection){
  // debugPrint("Selection => $selection");
    _multistudent = selection;
    notifyListeners();
}

// method to fetch available classes
void fetchClasses(String id){
  try{
  Client().get(Uri.parse(AppUrls.getClasses + id)).then((value) {
    if(value.statusCode == 200){
     _classes = classModelFromJson(value.body);
      notifyListeners();
    }
  });
   } on ClientException catch (_, e) {
      print( _.message);
    }
}

void fetchStreams(String id){
  try{
  Client().get(Uri.parse(AppUrls.getStreams + id)).then((value) {
    if(value.statusCode == 200){
     _streams = streamModelFromJson(value.body);
      notifyListeners();
    }
  });
   } on ClientException catch (_, e) {
      print( _.message);
    }
}
// dashboard class data
  void fetchDashboardClasses(String school) {
    try{
    Client().get(Uri.parse(AppUrls.dashboard + school)).then((value) {
    if(value.statusCode == 200){
     _dashboardClasses = dashboardModelFromJson(value.body);
      notifyListeners();
    }
  });
   } on ClientException catch (_, e) {
      print( _.message);
    }
  }
  // function to search for staff members by  either first name or last nam

  void searchStaff(String value){
     _searchStaff = staffData.where((element) => element.staffFname == value || element.staffLname == value).toList();
        notifyListeners();
  }
  // function to search for guardians by either first name or last name
  void searchGuardians(String value){
    _searchGuardian = guardians.where((element) => element.guardianFname == value || element.guardianLname == value).toList();
    notifyListeners();
  }
  // function to search for students by either first name or last name
  void searchStudents(String value){
    _searchStudent = students.where((element) => element.studentFname == value || element.studentLname == value).toList();
    notifyListeners();
  }
  //  function to search for drops offs by first name or last name
  void searchDropOffs(String value){
    _searchDropOff = dropOffData.where((element) => element.studentName.studentLname == value || element.studentName.studentFname == value).toList();
  }
  // function to search for pick ups by first name or last name 
  void searchPickUps(String value){
    _searchPickUp = pickUpData.where((element) => element.studentName_.studentFname == value || element.studentName_.studentLname == value).toList();
  }
}