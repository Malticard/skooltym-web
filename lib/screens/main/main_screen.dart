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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // app theme statecr
    context.read<ThemeController>().getTheme();
    // retrive session state
    BlocProvider.of<SchoolController>(context, listen: false).getSchoolData();
    BlocProvider.of<FirstTimeUserController>(context)
        .getFirstTimeUser(context.read<SchoolController>().state['role']);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey[200]
          : Theme.of(context).scaffoldBackgroundColor,
      drawer: SideMenu(
        scaffoldKey: _scaffoldKey,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            // BlocBuilder<FinanceFirstTimeController, bool>(
            //       builder: (context, finance) {
            //         // redirect to dashboard if not first time user
            //         if (finance == false && context.read<SchoolController>().state['role'] == 'Finance') {
            //             // Finance redirection
            //             BlocProvider.of<FinanceViewController>(context)
            //                 .pushWidget(const Dashboard());
            //             BlocProvider.of<FinanceTitleController>(context)
            //                 .setTitle("Dashboard");
            //             BlocProvider.of<SideBarController>(context)
            //                 .changeSelected(0);
            //         }
            //         return finance == false && context.read<SchoolController>().state['role'] == 'Finance'
            //             ? Expanded(
            //                 // default flex = 1
            //                 // and it takes 1/6 part of the screen
            //                 child: SideMenu(
            //                   scaffoldKey: _scaffoldKey,
            //                 ),
            //               )
            //             : const Center();
            //       },
            //     ),

            BlocBuilder<FirstTimeUserController, bool>(
              builder: (context, state) {
                // redirect to dashboard if not first time user
                if (state == false) {
                  // Admin redirection
                  BlocProvider.of<WidgetController>(context)
                      .pushWidget(const Dashboard());
                  BlocProvider.of<TitleController>(context)
                      .setTitle("Dashboard");
                  BlocProvider.of<SideBarController>(context).changeSelected(0);
                }
                return state == false
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
    );
  }
}
