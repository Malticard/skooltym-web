import '/exports/exports.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonAppbarView(
            titleText: "App Settings",
            iconData: Icons.arrow_back,
            onBackClick: () => Routes.popPage(context),
          ),
          Expanded(
            child: ListView(
              children: [
                TapEffect(
                  onClick: () =>
                      context.read<ThemeController>().toggleDarkLightTheme(),
                  child: SettingCard(
                    leading: const Icon(Icons.contrast_rounded),
                    titleText: "App theme",
                    subText: Theme.of(context).brightness == Brightness.dark
                        ? "Dark mode"
                        : "Light theme",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
