import '/exports/exports.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light().copyWith(
        scaffoldBackgroundColor: creamColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        canvasColor: snowColor,
      ),
      dark: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: MultiProvider(
          providers: [
            BlocProvider(create: (context) => WidgetController()),
            ChangeNotifierProvider(
              create: (context) => MainController(),
            ),
            BlocProvider(create: (context) => ThemeController()),
            BlocProvider(create: (context) => IntervalController()),
            BlocProvider(create: (context) => OvertimeRateController()),
            BlocProvider(create: (context) => PickUpController()),
            BlocProvider(create: (context) => DropOffController()),
            BlocProvider(create: (context) => SchoolController()),
            BlocProvider(create: (context) => AllowOvertimeController()),
            BlocProvider(create: (context) => LightDarkController()),
            BlocProvider(create: (context) => OnlineCheckerController()),
            BlocProvider(create: (context) => StudentController()),
          ],
          child: const MainScreen(),
        ),
      ),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Admin Panel',
    //   theme: ThemeData.dark().copyWith(
    //     scaffoldBackgroundColor: bgColor,
    //     textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
    //         .apply(bodyColor: Colors.white),
    //     canvasColor: secondaryColor,
    //   ),
    //   home: MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(
    //         create: (context) => MainController(),
    //       ),
    //     ],
    //     child: const MainScreen(),
    //   ),
    // );
  }
}
