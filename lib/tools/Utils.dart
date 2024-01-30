// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:admin/controllers/utils/LoaderController.dart';
import 'package:admin/models/SettingModel.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../global/SessionManager.dart';
import '../models/DropOffModels.dart';
import '../models/Guardians.dart';
import '../models/OvertimeModel.dart';
import '../models/StudentModel.dart';
import '/exports/exports.dart';

// login logic for the user
void loginUser(BuildContext context, String email, String password) async {
  if (context.read<SchoolController>().state.isNotEmpty) {
    BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();
  }
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
      .then((value) async {
    if (value.statusCode == 200 || value.statusCode == 201) {
      context.read<LoaderController>().setLoading = false;
      var data = jsonDecode(value.body);
      BlocProvider.of<SchoolController>(context).setSchoolData(data);
      BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();
      //
      log("Current session for first time is ${BlocProvider.of<FirstTimeUserController>(context).state}");
      if (data['isNewUser'] == true) {
        BlocProvider.of<TitleController>(context).setTitle("Change Password");
        // log("Changing title");
      } else {
        // update user data
        context.read<WidgetController>().pushWidget(0);
        context.read<TitleController>().setTitle("Dashboard");
        context
            .read<SideBarController>()
            .changeSelected(0, context.read<SchoolController>().state['role']);
        BlocProvider.of<FirstTimeUserController>(context).setFirstTimeUser(
          false,
        );
//
        BlocProvider.of<TitleController>(context).showTitle();
        BlocProvider.of<FinanceViewController>(context).showRecentWidget();
        BlocProvider.of<WidgetController>(context).showRecentWidget();
      }
      // for finance
      if (data['role'] == 'Admin' || data['role'] == 'Finance') {
        await SessionManager().storeToken(data['_token']);
        BlocProvider.of<SchoolController>(context).setSchoolData(data);
        // var token = await SessionManager().isTokenExpired();
        // log("Is token expired: $token");
        //
        Routes.namedRemovedUntilRoute(
          context,
          data['role'] == 'Admin' || data['role'] == 'Finance'
              ? Routes.home
              : Routes.login,
        );
        context.read<LoaderController>().setLoading = false;

        showMessage(
          context: context,
          msg: "Logged in  successfully..",
          type: 'success',
        );
      } else {
        context.read<LoaderController>().setLoading = false;

        showMessage(
            context: context, msg: "Account not authorized", type: 'warning');
      }
    } else {
      context.read<LoaderController>().setLoading = false;
      var data = jsonDecode(value.body);
      showMessage(context: context, msg: "${data['message']}", type: 'danger');
    }
  });
}

// global functions
Future<String> assignRole(String role) async {
  try {
    var response = await Client().get(Uri.parse(AppUrls.roles));
    final roles = rolesFromJson(response.body);
    var result = roles.firstWhere((element) => element.roleType == role);
    return result.id;
  } on ClientException catch (e, _) {
    return Future.error("Lost connection to server");
  }
}

Future<String?> fetchAndDisplayImage(String imageURL) async {
  // await Future.delayed(
  //   Duration(seconds: 2),
  // );
  // // await Client().get(Uri.parse(AppUrls.liveImages + imageURL));
  return imageURL;
}

String formatNumber(var number) {
  return NumberFormat('#,###').format(number);
}

Future<SettingsModel> fetchSettings(String schoolId) async {
  Response response =
      await Client().get(Uri.parse(AppUrls.settings + schoolId));
  // if (settingsModelFromJson(response.body).isNotEmpty)
  return settingsModelFromJson(response.body).first;
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
Future<StudentModel> fetchStudents(String id,
    {int page = 1, int limit = 20}) async {
  try {
    var res = await Client()
        .get(Uri.parse(AppUrls.students + id + "?page=$page&pageSize=$limit"));
    return studentModelFromJson(res.body);
  } on ClientException catch (e, _) {
    return Future.error("Lost connection to server");
  }
}

// fetching guardians
Future<Guardians> fetchGuardians(BuildContext context,
    {int page = 1, int limit = 20}) async {
  Response response = await Client().get(
    Uri.parse(AppUrls.getGuardians +
        context.read<SchoolController>().state['school'] +
        "?page=$page&pageSize=$limit"),
  );
  return gaurdiansFromJson(response.body);
}

// fetching dashboard classes
Future<List<DashboardModel>> fetchDashboardClassData(String schoolId) async {
  var response = await Client().get(Uri.parse(AppUrls.dashboard + schoolId));
  return dashboardModelFromJson(response.body);
}

Future<StaffModel> fetchStaffs(BuildContext context,
    {int page = 1, int limit = 20}) async {
  Response response = await Client().get(Uri.parse(AppUrls.staff +
      context.read<SchoolController>().state['school'] +
      "?page=$page&pageSize=$limit"));

  return staffModelFromJson(response.body);
}

// show successDialog
void showSuccessDialog(String name, BuildContext context,
    {VoidCallback? onPressed}) {
  showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
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
  showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
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
      const SizedBox(
        width: 30,
      ),
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
    "page": const ClassesUI(),
  },
  {
    "icon": "assets/icons/staff.svg",
    "title": "Streams",
    "page": const StreamsUI(),
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
Future<ClassModel> fetchClasses(String id,
    {int page = 1, int limit = 50}) async {
  var response = await Client()
      .get(Uri.parse(AppUrls.getClasses + id + "?page=$page&pageSize=$limit"));
  return classModelFromJson(response.body);
}

// method to fetch available classes
Future<StreamsModel> fetchStreams(String id,
    {int page = 1, int limit = 50}) async {
  var response = await Client()
      .get(Uri.parse(AppUrls.getStreams + id + "?page=$page&pageSize=$limit"));
  return streamsModelFromJson(response.body);
}

/// show snackbar message
/// @param type = 'danger' | 'info' | warning
void showMessage(
    {String type = 'info',
    String? msg,
    bool float = false,
    required BuildContext context,
    double opacity = 1,
    int duration = 5,
    Animation<double>? animation}) {
  int num = msg!.length;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.vertical,
      showCloseIcon: true,
      content: Text(msg),
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
      // animation:Tween<double>(begin:0,end:1).animate(AnimationController(duration: )),
      margin: EdgeInsets.only(
          right: 20, bottom: _bottom(context, num), left: _left(context, num)),
    ),
  );
}

double _left(BuildContext context, int num) {
  double width = MediaQuery.of(context).size.width;
  double factor = 1440 / width;
  double leftMargin =
      width * (1 - (factor * (0.1 + ((num - 1) * (num < 32 ? 0.01 : 0.0076)))));
  return leftMargin > 0 ? leftMargin : 20;
}

double _bottom(BuildContext context, int num) {
  double height = MediaQuery.of(context).size.height;
  return height * 0.88;
}

/// show progress widget
void showProgress(BuildContext context, {String? msg = 'Task'}) {
  showAdaptiveDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        child: Responsive(
          mobile: SizedBox(
            height: 90,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: SpinKitDualRing(
                      size: Responsive.isMobile(context) ? 35 : 45,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  width: 40,
                ),
                Text(
                  "$msg..",
                  textAlign: TextAlign.center,
                  style: TextStyles(context).getRegularStyle(),
                ),
              ],
            ),
          ),
          desktop: SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.width / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space(
                  space: 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SpinKitDualRing(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).primaryColor),
                ),
                Space(
                  space: 0.05,
                ),
                Text(
                  "$msg..",
                  textAlign: TextAlign.center,
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
        ),
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
  return DateFormat('dd-MM-yyyy').format(date);
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
  students = response.results.length;
  return students;
}

// fetch overtimes
// fetch pickups
Future<PickUpModel> fetchSpecificPickups(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.pickUps + id));
  return pickUpModelFromJson(response.body);
}

// fetch pickups
Future<PickUpModel> fetchPickUps(String id,
    {int page = 1, int limit = 20}) async {
  var response = await Client()
      .get(Uri.parse(AppUrls.getPickUps + id + "?page=$page&pageSize=$limit"));
  // debugPrint("response => ${response.body}");
  return pickUpModelFromJson(response.body);
}

// drop offs
Future<DropOffModel> fetchSpecificDropOffs(String id) async {
  var response = await Client().get(Uri.parse(AppUrls.specificDropOffs + id));
  return dropOffModelFromJson(response.body);
  // return response;
}

// drop offs
Future<DropOffModel> fetchDropOffs(String id,
    {int page = 1, int limit = 20}) async {
  var response = await Client()
      .get(Uri.parse(AppUrls.getDropOffs + id + "?page=$page&pageSize=$limit"));
  return dropOffModelFromJson(response.body);
  // return response;
}

/// *
/// Dashboard cards

// fetch overtimes
Future<OvertimeModel> fetchPendingOvertimeData(String id,
    {int page = 1, int limit = 50}) async {
  var response = await Client().get(
      Uri.parse(AppUrls.pendingOvertime + id + "?page=$page&limit=$limit"));
  return overtimeModelFromJson(response.body);
  // .where((element) => element.status == status)
  // .toList();
  // return response;
}

Future<OvertimeModel> fetchClearedOvertimeData(String id,
    {int page = 1, int limit = 50}) async {
  var response = await Client().get(
      Uri.parse(AppUrls.clearedOvertime + id + "?page=$page&limit=$limit"));
  return overtimeModelFromJson(response.body);
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

Future<PaymentModel> fetchPayments(String schoolId,
    {int page = 1, int limit = 50}) async {
  // if (ctx.read<SchoolController>().state['role'] == 'Finance') {
  Response response = await Client().get(
      Uri.parse(AppUrls.getPayment + schoolId + "?page=$page&pageSize=$limit"));
  // if (response.statusCode == 200 || response.statusCode == 201) {
  return paymentModelFromJson(response.body);
}

/// function to rename uplaoded file to a unique name
String renameFile(String fileName) {
  var uuid = Uuid();
  String fileExtension = fileName.split(".").last;
  return uuid.v4() + ".$fileExtension";
}

// fetch dashboard meta data
Future<List<Map<String, dynamic>>> fetchDashboardMetaData(
    String schoolId, String role) async {
  // context.read<PaymentController>().getPayments(context);
  var drops = await fetchDropOffs(schoolId);
  var picks = await fetchPickUps(schoolId);
  var pendingOvertimes = await fetchPendingOvertimeData(schoolId, limit: 150);
  var clearedOvertimes = await fetchClearedOvertimeData(schoolId, limit: 150);
  List<Map<String, dynamic>> dashboardData = [
    {
      "label": "DROP OFFS",
      "value": drops.totalDocuments,
      "icon": "assets/icons/004-playtime.svg",
      "page": 8,
      'color': const Color.fromARGB(255, 106, 108, 235),
    },
    {
      "label": "PICK UPS",
      "value": picks.totalDocuments,
      "icon": "assets/icons/009-student.svg",
      "page": 9,
      'color': const Color.fromARGB(255, 181, 150, 253),
    },
    {
      "label": "CLEARED OVERTIME",
      "value": clearedOvertimes.totalDocuments,
      "icon": "assets/icons/002-all.svg",
      "page": 7,
      'color': const Color.fromARGB(255, 77, 154, 255),
    },
    {
      "label": "PENDING OVERTIME",
      "value": pendingOvertimes.totalDocuments,
      "icon": "assets/icons/005-overtime.svg",
      "page": 6,
      'color': const Color.fromARGB(255, 50, 66, 95),
    },
  ];
  List<Map<String, dynamic>> financeData = [
    {
      "label": "CLEARED OVERTIME",
      "value": clearedOvertimes.totalDocuments,
      "icon": "assets/icons/005-overtime.svg",
      'color': Color.fromARGB(255, 19, 112, 15),
      "page": 2,
    },
    {
      "label": "PENDING OVERTIME",
      "value": pendingOvertimes.totalDocuments,
      "icon": "assets/icons/005-overtime.svg",
      'color': const Color.fromARGB(255, 50, 66, 95),
      "page": 1,
    },
    // {
    //   "label": "PAYMENTS",
    //   "value": pendingOvertimes.totalDocuments,
    //   "icon": "assets/icons/005-overtime.svg",
    //   'color': Color.fromARGB(255, 188, 180, 14),
    //   "page": 2,
    //   "last_updated": "14:45"
    // }
  ];
  return role == 'Admin' ? dashboardData : financeData;
}

// function to process images
Future<List<DashboardModel>> fetchDashBoardData(String school) async {
  Response response = await Client().get(Uri.parse(AppUrls.dashboard + school));
  return (dashboardModelFromJson(response.body));
}

// Initialize the latest timestamp to null
var latestTimestamp;
