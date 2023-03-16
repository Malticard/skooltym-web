import '/exports/exports.dart';

void main() {
  runApp(
    MultiProvider(
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
      child: BlocBuilder<ThemeController, ThemeData>(builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: theme.brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: theme.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(
                    bodyColor: theme.brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
          ),
          initialRoute: Routes.home,
          routes: routes(context),
        );
      }),
    ),
  );
}
