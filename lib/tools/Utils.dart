// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:intl/intl.dart';
import '/exports/exports.dart';

// login logic for the user
loginUser(BuildContext context, String email, String password) async {
  showProgress(context, msg: "Login in progress");
  Client()
      .post(Uri.parse(AppUrls.login),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: json.encode({
            "staff_contact": email,
            "staff_password": password,
          }))
      .then((value) {
    if (value.statusCode == 200 || value.statusCode == 201) {
      var data = jsonDecode(value.body);

      Routes.popPage(context);

      BlocProvider.of<SchoolController>(context).setSchoolData(data);
      //
      Routes.namedRemovedUntilRoute(
        context,
        data['role'] == 'Admin' ||
                data['role'] == 'SuperAdmin' ||
                data['role'] == 'Finance'
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

Future<Uint8List?> fetchAndDisplayImage(String imageURL) async {
  Uint8List? processedImageBytes;
  final response = await Client().get(Uri.parse(imageURL),headers: {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  });
  if (response.statusCode == 200) {
    final imageBytes = response.bodyBytes;
    final imageBase64 = base64Encode(imageBytes);
    // Display the image
    processedImageBytes = base64Decode(imageBase64);
  }
  return processedImageBytes;
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

// fetching dashboard classes
Future<List<DashboardModel>> fetchDashboardClassData(String schoolId) async {
  var response = await Client().get(Uri.parse(AppUrls.dashboard + schoolId));
  return dashboardModelFromJson(response.body);
}

// Future<StudentModel> getSpecificStudent(String n, String school) async {
//   var st = await fetchStudents(school);
//   return st.firstWhere((element) => element.studentFname == n);
// }

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
          child: const Text("Okay"),
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
Widget buildActionButtons(
    BuildContext context, VoidCallback edit, VoidCallback delete) {
  return Row(
    children: [
      CommonButton(
        onTap: edit,
        width: 50, height: 50,
        // padding: const EdgeInsets.only(top: 15, bottom: 15),
        buttonTextWidget: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      CommonButton(
        width: 50,
        height: 50,
        onTap: delete,
        backgroundColor: Colors.red,
        buttonTextWidget:
            const Icon(Icons.delete_outline_rounded, color: Colors.white),
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
    "title": "Staff",
    "page": const StaffView(),
  },
  {
    "title": "Guardians",
    "page": const ViewGuardians(),
    'icon': "assets/icons/guardian.svg"
  },
  {
    "icon": "assets/vectors/class.svg",
    "title": "Classes",
    "page": const Classes(),
  },
  {
    "icon": "assets/icons/staff.svg",
    "title": "Streams",
    "page": const Streams(),
  },
  {
    "title": "Pending Overtimes",
    "page": const PendingOvertime(),
    'icon': "assets/icons/menu_store.svg"
  },
  {
    "icon": "assets/icons/menu_store.svg",
    "title": "Cleared Overtimes",
    "page": const ClearedOvertime(),
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
    "page": const PendingOvertime(),
    'icon': "assets/icons/menu_store.svg"
  },
  {
    "icon": "assets/icons/menu_store.svg",
    "title": "Cleared Overtimes",
    "page": const ClearedOvertime(),
  },
  {
    "icon": "assets/vectors/payment.svg",
    "title": "Payments",
    "page": const PaymentReports(),
  },
  {
    "title": "Change Password",
    "page": const ChangePassword(),
    'icon': "assets/icons/password-reset.svg"
  },
];
// value limit
String valueLimit(String actual, String max) {
  return int.parse(actual) > int.parse(max) ? max : actual;
}

// valid text controllers
bool validateTextControllers(List<TextEditingController> controllers) {
  var ct = controllers.where((element) => element.text.isEmpty).toList();
  return ct.isEmpty ? true : false;
}

// method to fetch available classes
Future<List<ClassModel>> fetchClasses(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.getClasses + id));
  return classModelFromJson(response.body);
}

// method to fetch available classes
Future<List<StreamModel>> fetchStreams(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.getStreams + id));
  return streamModelFromJson(response.body);
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
                      ? const Color.fromARGB(255, 2, 104, 7)
                          .withOpacity(opacity)
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

String formatDateTime(DateTime date) {
  return DateFormat('hh:mm a').format(date);
}
String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
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
Future<List<OvertimeModel>> fetchOvertimeData(String status, String id) async {
  var response = await Client().get(Uri.parse(AppUrls.overtime + id));
  return overtimeModelFromJson(response.body)
      .where((element) => element.status == status)
      .toList();
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
Future<List<Map<String, dynamic>>> fetchDashboardMetaData(
    BuildContext context) async {
      context.read<PaymentController>().getPayments(context);
  var drops = await dropOffs(context.read<SchoolController>().state['school']);
  var picks = await pickUps(context.read<SchoolController>().state['school']);
  var clearedOvertimes = context.read<PaymentController>().state.where((element) => element.balance == 0).toList();
  var pendingOvertimes = context.read<PaymentController>().state.where((element) => element.balance == 0).toList();

  List<Map<String, dynamic>> dashboardData = [
    {
      "label": "DROP OFFS",
      "value": drops.length,
      "icon": "assets/icons/004-playtime.svg",
      'color': const Color.fromARGB(255, 106, 108, 235),
      // "last_updated": "14:45"
    },
    {
      "label": "PICK UPS",
      "value": picks.length,
      "icon": "assets/icons/009-student.svg",
      'color': const Color.fromARGB(255, 181, 150, 253),
      // "last_updated": "14:45"
    },
    {
      "label": "CLEARED OVERTIME",
      "value": clearedOvertimes.length,
      "icon": "assets/icons/002-all.svg",
      'color': const Color.fromARGB(255, 77, 154, 255),
      // "last_updated": "14:45"
    },
    {
      "label": "PENDING OVERTIME",
      "value": pendingOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': const Color.fromARGB(255, 50, 66, 95),
      // "last_updated": "14:45"
    },
  ];
  List<Map<String, dynamic>> financeData = [
    {
      "label": "CLEARED OVERTIME",
      "value": clearedOvertimes.length,
      "icon": "assets/icons/005-overtime.svg",
      'color': Color.fromARGB(255, 56, 212, 48), 
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
  return context.read<SchoolController>().state['role'] == 'Admin' ? dashboardData : financeData;
}

// function to process images
Uint8List processImage(String data){
  return Uri.parse(data).data!.contentAsBytes();
}
// Initialize the latest timestamp to null
var latestTimestamp;