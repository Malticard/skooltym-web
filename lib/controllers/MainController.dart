// ignore_for_file: unrelated_type_equality_checks

import '../models/DropOffModels.dart';
import '/exports/exports.dart';

class MainController with ChangeNotifier {
  List<Map<String, dynamic>> _dashData = [];

  List<StaffModel> _availableStaff = [];
  List<Streams> _streams = [];
  List<PaymentModel> _payments = [];
  List<DashboardModel> _dashboardClasses = [];
  // loader
  bool _isLoading = true;
  // searching arrays
  List<StaffModel> _searchStaff = [];

  List<DropOffModel> _searchDropOff = [];
  List<PickUpModel> _searchPickUp = [];
  // end of searching arrays
  List<ClassModel> _classes = [];
  int _stepCount = 0;
  List<dynamic> _multiguardian = [];
  List<dynamic> _multistudent = [];
  // List<OvertimeModel> _pendingOvertime = [];

// getters
  // List<StudentModel> get students => _students;
  List<StaffModel> get staffData => _availableStaff;
  // search getters
  List<StaffModel> get sStaff => _searchStaff;
  // List<StudentModel> get sStudent => _searchStudent;
  // List<Guardians> get sGuardian => _searchGuardian;
  List<DropOffModel> get sdropOff => _searchDropOff;
  List<PickUpModel> get sPickUp => _searchPickUp;
  List<DashboardModel> get dashboardClasses => _dashboardClasses;
  List<PaymentModel> get payments => _payments;

// get loader
  bool get isLoading => _isLoading;
  // end of search
  int get stepCount => _stepCount;
  List<Map<String, dynamic>> get dashboardData => _dashData;
  // List<OvertimeModel> get pendingOvertime => _pendingOvertime;
  List<dynamic> get multistudent => _multistudent;
  List<dynamic> get multiguardian => _multiguardian;
  List<ClassModel> get classes => _classes;
  List<Streams> get streams => _streams;

  // end of getters

  void controlMenu(GlobalKey<ScaffoldState> scaffoldKey) {
    // if (!scaffoldKey.currentState!.isDrawerOpen) {
    scaffoldKey.currentState!.openDrawer();
  }

// stepper text count
  void setTextCount(int value) {
    _stepCount = value;
    notifyListeners();
  }

//
  void selectMultiGuardians(List<dynamic> selection) {
    // debugPrint("Selection => $selection");
    _multiguardian = selection;
    notifyListeners();
  }

  void selectMultiStudent(List<dynamic> selection) {
    // debugPrint("Selection => $selection");
    _multistudent = selection;
    notifyListeners();
  }

// method to fetch available classes
  // void fetchClasses(String id) {
  //   Timer.periodic(const Duration(seconds: 5), (timer) {
  //     try {
  //       Client().get(Uri.parse(AppUrls.getClasses + id)).then((value) {
  //         if (value.statusCode == 200) {
  //           _classes = classModelFromJson(value.body);
  //           notifyListeners();
  //         }
  //       });
  //     } on ClientException catch (_) {
  //       print(_.message);
  //     }
  //   });
  // }

  // void fetchStreams(String id) {
  //   try {
  //     Client().get(Uri.parse(AppUrls.getStreams + id)).then((value) {
  //       if (value.statusCode == 200) {
  //         _streams = streamModelFromJson(value.body);
  //         notifyListeners();
  //       }
  //     });
  //   } on ClientException catch (_) {
  //     print(_.message);
  //   }
  // }

// dashboard class data
  void fetchDashboardClasses(String school) {
    try {} on ClientException catch (_) {
      print(_.message);
    }
  }
  // function to search for staff members by  either first name or last nam

  // void searchStaff(String value) {
  //   _searchStaff = staffData
  //       .where((element) =>
  //           element.staffFname == value || element.staffLname == value)
  //       .toList();
  //   notifyListeners();
  // }

  // function to search for guardians by either first name or last name
  // void searchGuardians(String value) {
  //   _searchGuardian = guardians
  //       .where((element) =>
  //           element.guardianFname == value || element.guardianLname == value)
  //       .toList();
  //   notifyListeners();
  // }

  // function to search for students by either first name or last name
  // void searchStudents(String value) {
  //   _searchStudent = students
  //       .where((element) =>
  //           element.studentFname == value || element.studentLname == value)
  //       .toList();
  //   notifyListeners();
  // }

  //  function to search for drops offs by first name or last name
  // void searchDropOffs(String value) {
  //   _searchDropOff = dropOffData
  //       .where((element) =>
  //           element.studentName.studentLname == value ||
  //           element.studentName.studentFname == value)
  //       .toList();
  // }

  // function to search for pick ups by first name or last name
  // void searchPickUps(String value) {
  //   _searchPickUp = pickUpData
  //       .where((element) =>
  //           element.studentN.studentFname == value ||
  //           element.studentN.studentLname == value)
  //       .toList();
  // }

  // fetching payments
  void fetchPayments(BuildContext context) {}
}
