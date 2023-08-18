import '../../controllers/MenuAppController.dart';
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
    context.read<SchoolController>().getSchoolData();
    BlocProvider.of<FirstTimeUserController>(context)
        .getFirstTimeUser(context.read<SchoolController>().state['role']);
    // app theme state
    context.read<ThemeController>().getTheme();
    // retrieve session state
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ThemeController>().getTheme();
    // retrieve session state
    context.read<SchoolController>().getSchoolData();

    BlocProvider.of<FirstTimeUserController>(context)
        .getFirstTimeUser(context.read<SchoolController>().state['role']);
  }

  @override
  void dispose() {
    super.dispose();
    context.read<MenuAppController>().disposeController();
  }

  @override
  Widget build(BuildContext context) {
    // app theme state
    context.read<ThemeController>().getTheme();
    // retrieve session state
    BlocProvider.of<SchoolController>(context, listen: false).getSchoolData();
    BlocProvider.of<FirstTimeUserController>(context)
        .getFirstTimeUser(context.read<SchoolController>().state['role']);

    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey[200]
          : Theme.of(context).scaffoldBackgroundColor,
      drawer: SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            BlocBuilder<FirstTimeUserController, bool>(
              builder: (context, state) {
                // redirect to dashboard if not first time user
                if (state == false) {
                  // Admin redirection
                  BlocProvider.of<WidgetController>(context).showRecentWidget();
                  BlocProvider.of<FinanceViewController>(context)
                      .showRecentWidget();
                  BlocProvider.of<TitleController>(context).showTitle(
                      context.read<SchoolController>().state['role']);
                  BlocProvider.of<SideBarController>(context)
                      .showCurrentSelection(
                          context.read<SchoolController>().state['role']);
                }
                return state == false
                    ? Expanded(
                        // default flex = 1
                        // and it takes 1/6 part of the screen
                        child: SideMenu(),
                      )
                    : const Center();
              },
            ),
          Expanded(
            // It takes 5/6 part of the screen
            flex: 5,
            child: DashboardScreen(),
          ),
        ],
      ),
    );
  }
}
