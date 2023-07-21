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
    BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();
    // app theme state
    context.read<ThemeController>().getTheme();
    // retrive session state
    context.read<SchoolController>().getSchoolData();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ThemeController>().getTheme();
    // retrive session state
    context.read<SchoolController>().getSchoolData();
  
    BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // app theme state
    context.read<ThemeController>().getTheme();
    // retrive session state
    context.read<SchoolController>().getSchoolData();
  

    BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();
    BlocProvider.of<FinanceFirstTimeController>(context).getFirstTime();
    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: _scaffoldKey,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
                    BlocBuilder<FinanceFirstTimeController, bool>(
                          builder: (context, finance) {
                            // redirect to dashboard if not first time user
                            if (finance == false && context.read<SchoolController>().state['role'] == 'Finance') {
                                // Finance redirection
                                BlocProvider.of<FinanceViewController>(context)
                                    .pushWidget(const Dashboard());
                                BlocProvider.of<FinanceTitleController>(context)
                                    .setTitle("Dashboard");
                                BlocProvider.of<SideBarController>(context)
                                    .changeSelected(0);
                            }
                            return finance == false && context.read<SchoolController>().state['role'] == 'Finance'
                                ? Expanded(
                                    // default flex = 1
                                    // and it takes 1/6 part of the screen
                                    child: SideMenu(
                                      scaffoldKey: _scaffoldKey,
                                    ),
                                  )
                                : const Center();
                          },
                        ),
                  
                        BlocBuilder<FirstTimeUserController, bool>(
                          builder: (context, state) {
                            // redirect to dashboard if not first time user
                            if (state == false && context.read<SchoolController>().state['role'] == 'Admin') {
                              // Admin redirection
                                BlocProvider.of<WidgetController>(context)
                                    .pushWidget(const Dashboard());
                                BlocProvider.of<TitleController>(context)
                                    .setTitle("Dashboard");
                                BlocProvider.of<SideBarController>(context)
                                    .changeSelected(0);
                            }
                            return state == false&& context.read<SchoolController>().state['role'] == 'Admin'
                                ? Expanded(
                                    // default flex = 1
                                    // and it takes 1/6 part of the screen
                                    child: SideMenu(
                                      scaffoldKey: _scaffoldKey,
                                    ),
                                  )
                                : const Center();
                          },
                        ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(
                scaffoldKey: _scaffoldKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
