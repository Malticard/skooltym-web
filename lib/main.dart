import 'package:admin/global/SessionManager.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '/exports/exports.dart';
import 'controllers/MenuAppController.dart';
import 'controllers/utils/LoaderController.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  // Obtain shared preferences.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //  setPathUrlStrategy();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer = const Observer();

  bool isExpired = await SessionManager().isTokenExpired();

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
        ChangeNotifierProvider(create: (context) => LoaderController()),
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
        listener: (context, theme) {
          BlocProvider.of<SchoolController>(context, listen: false)
              .getSchoolData();
        },
        builder: (context, theme) {
          BlocProvider.of<SchoolController>(context, listen: true)
              .getSchoolData();
          BlocProvider.of<TitleController>(context).showTitle();
          return BlocBuilder<TitleController, String>(
            builder: (context, title) {
              return MaterialApp(
                title: "Skooltym  | $title",
                theme: theme,
                initialRoute: (isExpired == true) ? Routes.login : Routes.home,
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
