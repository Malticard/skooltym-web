import '/exports/exports.dart';

Future<void> main() async {
  // Obtain shared preferences.
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const Observer();
  var prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => DashboardCardsController()),
        BlocProvider(create: (context) => FetchStudentsController()),
        BlocProvider(create: (context) => DashboardDataController()),
        BlocProvider(create: (context) => PickUpsController()),
        BlocProvider(create: (context) => StreamsController()),
        BlocProvider(create: (context) => StaffController()),
        BlocProvider(create: (context) => GuardianController()),
        BlocProvider(create: (context) => DropOffController()),
        BlocProvider(create: (context) => ClassController()),
        BlocProvider(create: (context) => PaymentController()),
        BlocProvider(create: (context) => WidgetController()),
        BlocProvider(create: (context) => ImageUploadController()),
        BlocProvider(create: (context) => SideBarController()),
        BlocProvider(create: (context) => FirstTimeUserController()),
        BlocProvider(create: (context) => FinanceFirstTimeController()),
        ChangeNotifierProvider(create: (context) => MainController()),
        BlocProvider(create: (context) => ThemeController()),
        BlocProvider(create: (context) => IntervalController()),
        BlocProvider(create: (context) => OvertimeRateController()),
        BlocProvider(create: (context) => PickUpAllowanceTimeController()),
        BlocProvider(create: (context) => DropOffAllowanceController()),
        BlocProvider(create: (context) => SchoolController()),
        BlocProvider(create: (context) => AllowOvertimeController()),
        BlocProvider(create: (context) => LightDarkController()),
        BlocProvider(create: (context) => OnlineCheckerController()),
        BlocProvider(create: (context) => StudentController()),
        BlocProvider(create: (context) => TitleController()),
        BlocProvider(create: (context) => DashboardController()),
        BlocProvider(create: (context) => StepperController()),
        BlocProvider(create: (context) => ClassNameController()),
        BlocProvider(create: (context) => ForgotPasswordController()),
        BlocProvider(create: (context) => SettingsController()),
        BlocProvider(create: (context) => MultiStudentsController()),
        BlocProvider(create: (context) => FinanceViewController()),
        BlocProvider(create: (context) => FinanceTitleController()),
        BlocProvider(create: (context) => DropOffTimeController()),
        BlocProvider(create: (context) => PickUpTimeController()),
      ],
      child: BlocBuilder<ThemeController, ThemeData>(
        builder: (context, theme) {
          BlocProvider.of<SchoolController>(context).getSchoolData();
          return MaterialApp(
            // debugShowCheckedModeBanner: false,xs
            themeMode: theme.brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: theme.copyWith(
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .apply(
                bodyColor: theme.brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                displayColor: theme.brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            initialRoute: prefs.containsKey('schoolData') == true &&
                    context.read<SchoolController>().state['role'] != null
                ? Routes.home
                : Routes.login,
            routes: routes(context),
          );
        },
      ),
    ),
  );
}
