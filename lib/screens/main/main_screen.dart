import 'package:admin/global/SessionManager.dart';

import '../../controllers/MenuAppController.dart';
import '/exports/exports.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Timer? _timer;
  @override
  void initState() {
    if (mounted) {
      // retrieve session state
      context.read<SchoolController>().getSchoolData();

      BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();
    }
    // app theme state
    context.read<ThemeController>().getTheme();
    // retrieve session state
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      _timer = timer;
      SessionManager().isTokenExpired().then((value) async {
        if (value == true) {
          await SessionManager().clearToken();
          timer.cancel();
          // redirect to login
          showAdaptiveDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                    title: Text('Session expired'),
                    content: Text('Please login again'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Routes.namedRemovedUntilRoute(
                                context, Routes.login);
                            showMessage(
                              context: context,
                              msg: "Session expired",
                              type: 'info',
                            );
                          },
                          child: Text('Ok'))
                    ]);
              });
          // Routes.namedRemovedUntilRoute(context, Routes.login);
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
      context.read<ThemeController>().getTheme();
      // retrieve session state
      context.read<SchoolController>().getSchoolData();

      BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer!.isActive) {
      _timer?.cancel();
    }
    _timer?.cancel();
    context.read<MenuAppController>().disposeController();
  }

  @override
  Widget build(BuildContext context) {
    // app theme state
    context.read<ThemeController>().getTheme();
    // retrieve session state
    BlocProvider.of<SchoolController>(context, listen: true).getSchoolData();

    BlocProvider.of<FirstTimeUserController>(context).getFirstTimeUser();

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
                  BlocProvider.of<TitleController>(context).showTitle();
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
