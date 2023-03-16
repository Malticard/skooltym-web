import '/exports/exports.dart';

class PopUpOptions {
  String? title;
  IconData? icon;
  final String route;
  PopUpOptions({this.title, this.icon, required this.route});

  static final List<PopUpOptions> options = [
    PopUpOptions(
        title: "Settings", icon: Icons.settings, route: Routes.settings),
    PopUpOptions(title: "Logout", icon: Icons.logout, route: Routes.login),
  ];
}
