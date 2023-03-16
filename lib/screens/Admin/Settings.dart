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
      "title": "App Settings",
      "page": const AppSettings(),
      'icon': SettingIcons.appSetIcon
    },
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
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: List.generate(
          pageDetails.length,
          (index) => Card(
            margin: const EdgeInsets.only(
                top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
            elevation: 0,
            child: OpenContainer(
              closedColor: Theme.of(context).scaffoldBackgroundColor,
              closedElevation: 0,
              transitionType: ContainerTransitionType.fadeThrough,
              transitionDuration: const Duration(milliseconds: 800),
              openColor: Theme.of(context).scaffoldBackgroundColor,
              closedBuilder: (context, action) => SettingCard(
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
              openBuilder: (context, action) => pageDetails[index]['page'],
            ),
          ),
        ),
      ),
    );
  }
}
