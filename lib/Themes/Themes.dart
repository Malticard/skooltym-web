// ignore_for_file: deprecated_member_use

import '../exports/exports.dart';

class AppThemes {
  // light theme
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: creamColor,
    textTheme: GoogleFonts.aBeeZeeTextTheme(),
    drawerTheme: DrawerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Color.fromARGB(204, 9, 87, 139),
    ),
    useMaterial3: true,
    canvasColor: snowColor,
    backgroundColor: const Color.fromARGB(204, 9, 87, 139),
  );
//
  static final ThemeData darkTheme = ThemeData(
    drawerTheme: DrawerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
    textTheme: GoogleFonts.aBeeZeeTextTheme(),
    primaryColor: Color.fromARGB(204, 9, 87, 139),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromARGB(204, 255, 255, 255),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: bgColor,
    canvasColor: secondaryColor,
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
  );
}
