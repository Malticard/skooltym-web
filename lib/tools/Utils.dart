import 'dart:convert';
import 'dart:ui';

import '/exports/exports.dart';

// login logic for the user
loginUser(BuildContext context, String email, String password) async {
  showProgress(context, msg: "Login in progress");

  Client().post(Uri.parse(AppUrls.login),headers:  {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    } ,body:json.encode({
    "staff_contact": email,
    "staff_password": password,
  })).then((value) {
    if (value.statusCode == 200 || value.statusCode == 201) {
      var data = jsonDecode(value.body);

      Routes.popPage(context);
      debugPrint("Login response ${data}");

      BlocProvider.of<SchoolController>(context).setSchoolData(data);
      // 
      Routes.namedRemovedUntilRoute(
        context,
        data['role'] == 'Admin' ||  data['role'] == 'SuperAdmin' || data['role'] == 'Finance'
            ? Routes.home
            : Routes.login,
      );
      showMessage(
        context: context,
        msg: "Logged in  successfully..",
        type: 'success',
      );
    } else {
      var data = jsonDecode(value.body);
      Routes.popPage(context);
      showMessage(
          context: context,
          msg: "${value.statusCode} => ${data['message']}",
          type: 'danger');
    }
  }).whenComplete(() {});
  // final prefs = await SharedPreferences.getInstance();
  // prefs.setString('role', "${context.read<SchoolController>().state['role']}");
}

// global functions
Future<String> assignRole(String role) async {
  var response = await Client().get(Uri.parse(AppUrls.roles));
  final roles = rolesFromJson(response.body);
  var result = roles.firstWhere((element) => element.roleType == role);
  return result.id;
}

// greetings
String greetUser() {
  String greet = '';
  var time = TimeOfDay.now();
  int t = time.hour;
  if (t > 20) {
    greet = "Good night";
  } else if (t < 20 && t > 15) {
    greet = "Good evening";
  } else if (t > -1 && t < 13) {
    greet = "Good morning";
  } else {
    greet = "Good afternoon";
  }

  return greet;
}
// return students
Future<List<StudentModel>> fetchStudents(String id) async {
  var res = await Client().get(Uri.parse(AppUrls.students + id));
  return studentModelFromJson(res.body);
}

Future<StudentModel> getSpecificStudent(String n,String school) async {
  var st = await fetchStudents(school);
  return st.firstWhere((element) => element.studentFname == n);
}

// show successDialog
void showSuccessDialog(String name, BuildContext context,
    {VoidCallback? onPressed}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "$name added successfully",
        textAlign: TextAlign.center,
        // overflow: TextOverflow,
        style: TextStyles(context).getRegularStyle(),
      ),
      content: const Icon(Icons.check_circle_outline_rounded,
          size: 75, color: Colors.green),
      actions: [
        TextButton(
          onPressed: onPressed ??
              () {
                Routes.popPage(context);
                // context.read<WidgetController>().pushWidget(const AddClass());
                // context.read<TitleController>().setTitle("Classes");
                // Routes.namedRoute(context, Routes.dashboard);
              },
          child:const Text("Okay"),
        )
      ],
    ),
  );
}

// show content dialog
void showContentDialog(String name, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        name,
        overflow: TextOverflow.visible,
        style: TextStyles(context).getRegularStyle(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Routes.popPage(context);
            // Routes.namedRoute(context, Routes.dashboard);
          },
          child: Text(
            "Okay",
            style: TextStyles(context).getRegularStyle(),
          ),
        )
      ],
    ),
  );
}

// validate email
bool validateEmail(String email, BuildContext context) {
  bool isValid = true;
  String error = '';
  if (email.trim().isEmpty) {
    error = "Email can't be empty";

    isValid = false;
  } else if (!Validator_.validateEmail(email.trim())) {
    error = "Provide a valid email";

    isValid = false;
  }
  if (error != '') {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        // behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }

  return isValid;
}

// action buttons
// build Action Buttons
Widget buildActionButtons(BuildContext context,VoidCallback
edit,VoidCallback delete) {
  return context.read<SchoolController>().state['role'] == 'Finance'?TextButton(
        onPressed: edit,
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ): Row(
    children: [
      TextButton(
        onPressed: edit,
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      TextButton(
        onPressed: delete,
        style: TextButton.styleFrom(
          backgroundColor: Colors.red,
          padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
    ],
  );
}
// build dashboard cards

// sidebar data
List<Map<String, dynamic>> options = [
  {
    "icon": "assets/icons/menu_dashbord.svg",
    "title": "Dashboard",
    "page": const Dashboard()
  },
  {
    "icon": "assets/icons/student.svg",
    "title": "Students",
    "page": const ViewStudents()
  },
  {
    "icon": "assets/icons/staff.svg",
    "title": "Staffs",
    "page":  const StaffView(),
  },
  {
    "title": "Guardians",
    "page": const ViewGuardians(),
    'icon': "assets/icons/guardian.svg"
  },
  {
    "icon": "assets/icons/staff.svg",
    "title": "Classes",
    "page": const AddClass(),
  },
  {
    "title": "Pending Overtimes",
    "page": const OvertimeReports(overtimeStatus: "Pending",label: "Pending",),
    'icon': "assets/icons/menu_store.svg"
  },
  {
    "icon": "assets/icons/menu_store.svg",
    "title": "Cleared Overtimes",
    "page": const OvertimeReports(overtimeStatus: "Cleared",label: "Cleared",),
  },
  {
    "title": "Drop Offs",
    "page": const ViewDropOffs(),
    'icon': "assets/icons/menu_tran.svg"
  },
  {
    "title": "Pick Ups",
    "page": const ViewPickUps(),
    'icon': "assets/icons/menu_tran.svg"
  },
  {
    "title": "Change Password",
    "page": const ChangePassword(),
    'icon': "assets/icons/password-reset.svg"
  },
  {
    "title": "System Settings",
    "page": const SystemSettings(),
    'icon': "assets/icons/menu_setting.svg"
  }
];
// finance routes
List<Map<String, dynamic>> financeViews = [
  {
    "icon": "assets/icons/menu_dashbord.svg",
    "title": "Dashboard",
    "page": const Dashboard()
  },
  {
    "title": "Pending Overtimes",
    "page": const OvertimeReports(overtimeStatus: "Pending",),
    'icon': "assets/icons/menu_store.svg"
  },
  {
    "icon": "assets/icons/menu_store.svg",
    "title": "Cleared Overtimes",
    "page": const OvertimeReports(overtimeStatus: "Cleared",),
  },{
    "title": "Change Password",
    "page": const ChangePassword(),
    'icon': "assets/icons/password-reset.svg"
  },
];

// valid text controllers
bool validateTextControllers(List<TextEditingController> controllers) {
  var ct = controllers.where((element) => element.text.isEmpty).toList();
  return ct.isEmpty ? true : false;
}

/// show snackbar message
/// @param type = 'danger' | 'info' | warning
///
///
void showMessage(
    {String type = 'info',
    String? msg,
    bool float = false,
    required BuildContext context,
    double opacity = 1,
    int duration = 5,
    Animation<double>? animation}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: float ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      content: Text(msg ?? ''),
      backgroundColor: type == 'info'
          ? Colors.lightBlue
          : type == 'warning'
              ? Colors.orange[800]!.withOpacity(opacity)
              : type == 'danger'
                  ? Colors.red[800]!.withOpacity(opacity)
                  : type == 'success'
                      ? const Color.fromARGB(255, 2, 104, 7).withOpacity(opacity)
                      : Colors.grey[600]!.withOpacity(opacity),
      duration: Duration(seconds: duration),
    ),
  );
}

// show progress widget
void showProgress(BuildContext context, {String? msg}) {
  showModal(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    context: context,
    builder: (context) => BottomSheet(
      enableDrag: false,
      backgroundColor: Colors.black12,
      onClosing: () {},
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitDualRing(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Theme.of(context).primaryColor),
          const Space(
            space: 0.03,
          ),
          Text(
            msg ?? "Task in progress",
            style: TextStyles(context)
                .getRegularStyle()
                .copyWith(color: Colors.white),
          )
        ],
      ),
    ),
  );
}

// mark dates
String markDates(int date) {
  if (date == 1 || date == 21 || date == 31) {
    return "${date}st";
  } else if (date == 2 || date == 22) {
    return "${date}nd";
  } else if (date == 3 || date == 23) {
    return "${date}rd";
  }
  return "${date}th";
}

// configure am / pm
String amPm() {
  return time.hour > 0 && time.hour < 12 ? "am" : "pm";
}

// Days of the week
List<String> days = <String>["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
// months of the year
List<String> months = <String>[
  "Jan",
  "Feb",
  "Marc",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];
// compute students total
Future<int> computeStudentsTotal(String id) async {
  int students = 0;
  var response = await fetchStudents(id);
  students = response.length;
  // debugPrint("Total => $students");
  return students;
}

// fetch overtimes
// fetch pickups
Future<List<PickUpModel>> fetchPickups(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.pickUps + id));
  return response.statusCode == 201 || response.statusCode == 200
      ? pickUpModelFromJson(response.body)
      : [];
  // return;
  // return response;
}

// fetch pickups
Future<List<PickUpModel>> pickUps(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.getPickUps + id));
  // debugPrint("response => ${response.body}");
  return response.statusCode == 201 || response.statusCode == 200
      ? pickUpModelFromJson(response.body)
      : [];
  // return;
  // return response;
}

// drop offs
Future<List<DropOffModel>> fetchDropOffs(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.dropOffs + id));
  return dropOffModelFromJson(response.body);
  // return response;
}

// drop offs
Future<List<DropOffModel>> dropOffs(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.getDropOffs + id));
  return dropOffModelFromJson(response.body);
  // return response;
}

/// *
/// Dashboard cards

// fetch overtimes
Future<List<OvertimeModel>> fetchOvertimeData(String status,String id) async {
  var response = await Client().get(Uri.parse(AppUrls.overtime + id));
  return overtimeModelFromJson(response.body).where((element) => element.status == status).toList();
  // return response;
}

// function handling scan intervals

DateTime time = DateTime.now();
String handSanIntervals() {
  return time.hour > 6 && time.hour < 12
      ? "DropOffs"
      : time.hour > 12 && time.hour < 18
          ? "PickUps"
          : "Nothing taking place currently";
}

// fetch dashboard meta data
Future<List<Map<String, dynamic>>> fetchDashboardMetaData(String school_id,String role) async {
  // get students total
  // ignore: unused_local_variable
  int students = await computeStudentsTotal(school_id);
  var drops = await dropOffs(school_id);
  var picks = await pickUps(school_id);
  var clearedOvertimes = await fetchOvertimeData("Cleared",school_id);
  var pendingOvertimes = await fetchOvertimeData("Pending",school_id);

  List<Map<String, dynamic>> dashboardData = [
    {
      "label": "DROP OFFS",
      "value": drops.length,
      "icon": "assets/icons/004-playtime.svg",
      'color': const Color.fromARGB(255, 106, 108, 235),
      "last_updated": "14:45"
    },
    {
      "label": "PICK UPS",
      "value": picks.length,
      "icon": "assets/icons/009-student.svg",
      'color': const Color.fromARGB(255, 181, 150, 253),
      "last_updated": "14:45"
    },
    {
      "label": "CLEARED OVERTIME",
      "value": clearedOvertimes.length,
      "icon": "assets/icons/002-all.svg",
      'color': const Color.fromARGB(255, 77, 154, 255),
      "last_updated": "14:45"
    },
    {
      "label": "PENDING OVERTIME",
      "value": pendingOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': const Color.fromARGB(255, 50, 66, 95),
      "last_updated": "14:45"
    },
  ];
  List<Map<String, dynamic>> financeData = [
    {
      "label": "CLEARED OVERTIME",
      "value": clearedOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': const Color.fromARGB(255, 50, 66, 95),
      "last_updated": "14:45"
    },
    {
      "label": "PENDING OVERTIME",
      "value": pendingOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': const Color.fromARGB(255, 50, 66, 95),
      "last_updated": "14:45"
    },
  ];
  return role == 'Admin'
      ? dashboardData
      : financeData;
}

// logic to fetch a specific guardian from the scanners
Future<Map<String, dynamic>> fetchSpecificGuardian(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.getGuardian + id));
  debugPrint("Response ${response.body}");
  var guardianData = guardianModelFromJson(response.body);
// get the coresponding student for this guardian
  var student =
      await Client().get(Uri.parse(AppUrls.getStudent + guardianData.student));
  var studentData = studentModelFromJson(student.body)[0];
  //  fetch the corresponding guardians or other guardians
  var otherGuardians = await Client()
      .get(Uri.parse(AppUrls.getOtherGaurdians + guardianData.student));
  var otherGuardianData = guardiansFromJson(otherGuardians.body);
  // output resonse of data
  Map<String, dynamic> results = {
    "student_name": "${studentData.studentFname} ${studentData.studentLname}",
    "student_pic": studentData.studentProfilePic,
    "student_class": studentData.studentModelClass,
    "student_id": studentData.id,
    "picker_name":
        "${guardianData.guardianFname} ${guardianData.guardianLname}",
    "picker_id": guardianData.id,
    "relationship": guardianData.relationship,
    "picker_contact": guardianData.guardianContact,
    "others": otherGuardianData
  };
  return results;
}

registerDropOffOrPickUp(var data, BuildContext context) async {
  String msg = handSanIntervals();
  // save dropoff or pickup

  var response = await Client().post(
      Uri.parse(handSanIntervals() == "PickUps"
          ? AppUrls.addPickUp
          : AppUrls.addDropOff),
      body: data);
  if (response.statusCode == 201) {
    Routes.popPage(context);
    showMessage(
        context: context, msg: "$msg registered successfully", type: 'success');

    // showSuccessDialog("$msg registered successfully", context);
    Routes.namedRoute(context, Routes.home);
  } else {
    Routes.popPage(context);

    // showMessage(
    //     context: context,
    //     msg:
    //         "Error handling $handSanIntervals() ${response.statusCode} => ${response.reasonPhrase}",
    //     type: 'danger');
    showContentDialog(
        "Error handling $msg\n ${response.statusCode} => ${response.reasonPhrase}",
        context);
  }
}

// determine overtime
overtimes(BuildContext context) async {
  var checker = InternetConnectionChecker.createInstance();
  // String overtimeMsg = "";
  checker.hasConnection.then((online) {
    context.read<OnlineCheckerController>().updateChecker(online);
  });
  // check if the user is online
  if (context.read<OnlineCheckerController>().state) {
    // check if the user is online
    var response = await Client().get(Uri.parse(AppUrls.settings));
    if (response.statusCode == 201 || response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var overtime = data['overtime'];
      var overtimeStart = data['overtime_start'];
      var overtimeEnd = data['overtime_end'];
      var overtimeDuration = data['overtime_duration'];
      // var overtimeFee = data['overtime_fee'];
      // var overtimeMsg = data['overtime_msg'];
      // check if overtime is enabled
      if (overtime) {
        // check if the time is between the overtime start and end
        if (DateTime.now().isAfter(DateTime.parse(overtimeStart)) &&
            DateTime.now().isBefore(DateTime.parse(overtimeEnd))) {
          // check if the overtime duration is less than the overtime duration
          if (DateTime.now()
                  .difference(DateTime.parse(overtimeStart))
                  .inMinutes <
              int.parse(overtimeDuration)) {
            // show overtime dialog
            // showOvertimeDialog(
            //     context: context,
            //     overtimeFee: overtimeFee,
            //     overtimeMsg: overtimeMsg);
          }
        }
      }
    }
  } else {
    // show offline dialog
    showMessage(context: context, msg: "You are offline", type: "warning");
  }
}

// handle online and offline sessions
void handleNetworkSession(BuildContext context) {
  var checker = InternetConnectionChecker.createInstance();
  //
  checker.hasConnection.then((online) {
    context.read<OnlineCheckerController>().updateChecker(online);
  });
}
