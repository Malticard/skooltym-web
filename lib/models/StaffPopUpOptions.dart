import '/exports/exports.dart';

class StaffPopUpOptions {
  String? title;
  IconData? icon;
  final String route;
  StaffPopUpOptions({this.title, this.icon, required this.route});

  static final List<StaffPopUpOptions> options = [
    StaffPopUpOptions(
        title: "Profile",
        icon: Icons.person_3_rounded,
        route: Routes.staffProfile),
    StaffPopUpOptions(
        title: "Exit App", icon: Icons.exit_to_app_rounded, route: ""),
  ];
}
