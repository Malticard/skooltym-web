import '/exports/exports.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // app theme state
    context.read<ThemeController>().getTheme();
    // retrive session state
    context.read<SchoolController>().getSchoolData();
    context.read<MainController>().fetchUpdates(context.read<SchoolController>().state['school'] ?? "",context.read<SchoolController>().state['role'] ?? "");

    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  SideMenu(scaffoldKey: _scaffoldKey,),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(scaffoldKey: _scaffoldKey,),
              ),
             Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(scaffoldKey: _scaffoldKey,),
            ),
          ],
        ),
      ),
    );
  }
}
