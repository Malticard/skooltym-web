import '/exports/exports.dart';

class Routes {
  static const String login = "/userlogin";
  static const String onboardScreen = '/introductionScreen';
  static const String network = '/network';
  // static const String o = '/n';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/wksktyui';
  static const String changePassword = "/changePassword";
  static const String qrCode = "/home/staff/qrCode";
  static const String nfcView = "/home/staff/nfc";
  static const String dashboard = "/dashboard";
  static const String settings = "/dashboard/settings";
  static const String profile = "/dashboard/profile";
  static const String staffProfile = "/home/profile";
  static const String newStaff = "/dashboard/add/staff";
  static const String newStudent = "/dashboard/add/student";
  static const String newGuardian = "/dashboard/add/guardian";
  static const String finance = "/home/finance";
  static const String superAdminView = "/sdfghjkd345673lddf";

  static void push(Widget widget, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => widget, fullscreenDialog: true),
    );
  }

  static void namedRoute(BuildContext context, String route) {
    debugPrint("moved $route");
    Navigator.of(context).pushNamed(route);
  }

  static void namedRemovedUntilRoute(BuildContext context, String route) {
    debugPrint("moved $route");
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  static void popPage(BuildContext context) {
    Navigator.pop(context);
  }

  static void logout(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      value.clear();
    }).whenComplete(() => showMessage(
        context: context, type: 'info', msg: 'Signed out successfully'));
    namedRemovedUntilRoute(context, login); // navigates back login screen
  }
}

Map<String, Widget Function(BuildContext)> routes(BuildContext context) {
  return {
    Routes.home: (context) => const MainScreen(),
    Routes.login: (context) => LoginScreen(),
  };
}
