// ignore_for_file: library_private_types_in_public_api

import '/exports/exports.dart';

///  Created by bruno on 15/02/2023.
class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<Map<String, dynamic>> pageDetails = [
    {
      "title": "System Settings",
      "page": const SystemSettings(),
      'icon': SettingIcons.sysSetIcon
    },
    {
      "title": "Change Password",
      "page": const ChangePassword(),
      'icon': SettingIcons.changePasswordIcon
    },
    {
      "title": "Privacy policy",
      "page": const PrivacyPolicy(),
      'icon': SettingIcons.privacyIcon
    },
    {"title": "About", "page": const About(), 'icon': SettingIcons.aboutIcon},
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
      children: List.generate(
        pageDetails.length,
        (index) => SizedBox(
          height: MediaQuery.of(context).size.width * 0.0345,
          child: GridTile(
            child: SettingCard(
                color: Theme.of(context).canvasColor,
                leading: SizedBox(
                  width: MediaQuery.of(context).size.width / 4.5,
                  height: MediaQuery.of(context).size.width / 4.5,
                  child: Image.asset(
                    pageDetails[index]['icon'],
                    width: MediaQuery.of(context).size.width / 4.5,
                    height: MediaQuery.of(context).size.width / 4.5,
                  ),
                ),
                titleText: pageDetails[index]['title']),
          ),
        ),
      ),
    );
  }
}
