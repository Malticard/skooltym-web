import '../global/SessionManager.dart';
import '/exports/exports.dart';

class Routes {
  static const String login = "/adminLogin";
  static const String onboardScreen = '/introductionScreen';
  static const String network = '/network';
  // static const String o = '/n';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/dashboard';
  static const String phoneVerify = '/phoneVerify';

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
    Navigator.of(context).pushReplacementNamed(route);
  }

  static void popPage(BuildContext context) {
    Navigator.pop(context);
  }

  static void logout(BuildContext context) async {
    showProgress(context, msg: "Signing out");
    // clear all set data

    await SessionManager().clearToken();
    showMessage(
        context: context, type: 'success', msg: 'Signed out successfully');
    namedRemovedUntilRoute(context, login);
  }
}

Map<String, Widget Function(BuildContext)> routes(BuildContext context) {
  return {
    Routes.home: (context) => const MainScreen(),
    Routes.login: (context) => LoginScreen(),
    Routes.forgotPassword: (context) => const ChangePassword(),
    Routes.phoneVerify: (context) => PhoneVerify(),
  };
}
