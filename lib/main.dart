import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/exports/exports.dart';
import 'controllers/MenuAppController.dart';

Future<void> main() async {
  // Obtain shared preferences.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer = const Observer();
  var prefs = await SharedPreferences.getInstance();
  // prefs.clear().then((value) {});
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FetchStudentsController()),
        BlocProvider(create: (context) => GuardianController()),
        ChangeNotifierProvider(create: (context) => ClassController()),
        BlocProvider(create: (context) => WidgetController()),
        BlocProvider(create: (context) => ImageUploadController()),
        BlocProvider(create: (context) => SideBarController()),
        BlocProvider(create: (context) => FirstTimeUserController()),
        BlocProvider(create: (context) => FinanceFirstTimeController()),
        ChangeNotifierProvider(create: (context) => MainController()),
        ChangeNotifierProvider(create: (context) => MenuAppController()),
        ChangeNotifierProvider(create: (context) => StreamsController()),
        BlocProvider(create: (context) => ThemeController()),
        BlocProvider(create: (context) => IntervalController()),
        BlocProvider(create: (context) => OvertimeRateController()),
        BlocProvider(create: (context) => PickUpAllowanceTimeController()),
        BlocProvider(create: (context) => DropOffAllowanceController()),
        BlocProvider(create: (context) => SchoolController()),
        BlocProvider(create: (context) => AllowOvertimeController()),
        BlocProvider(create: (context) => OnlineCheckerController()),
        BlocProvider(create: (context) => TitleController()),
        BlocProvider(create: (context) => ClassNameController()),
        BlocProvider(create: (context) => ForgotPasswordController()),
        BlocProvider(create: (context) => SettingsController()),
        BlocProvider(create: (context) => MultiStudentsController()),
        BlocProvider(create: (context) => FinanceViewController()),
        BlocProvider(create: (context) => FinanceTitleController()),
        BlocProvider(create: (context) => DropOffTimeController()),
        BlocProvider(create: (context) => PickUpTimeController()),
      ],
      child: BlocConsumer<ThemeController, ThemeData>(
        listener: (context, theme) {},
        builder: (context, theme) {
          BlocProvider.of<SchoolController>(context).getSchoolData();
          BlocProvider.of<TitleController>(context).showTitle(
              BlocProvider.of<SchoolController>(context, listen: true)
                      .state['role'] ??
                  "guest");
          return BlocBuilder<TitleController, String>(
            builder: (context, title) {
              return MaterialApp(
                title: "Skooltym  | $title",
                // debugShowCheckedModeBanner: false,xs
                themeMode: theme.brightness == Brightness.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                theme: theme.copyWith(
                  textTheme:
                      GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme)
                          .apply(
                    bodyColor: theme.brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    displayColor: theme.brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  useMaterial3: true,
                ),
                initialRoute: prefs.containsKey('schoolData') == true &&
                        context.read<SchoolController>().state['role'] != null
                    ? Routes.home
                    : Routes.login,
                routes: routes(context),
              );
            },
          );
        },
      ),
    ),
  );
  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}
