import '../exports/exports.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: creamColor,
    canvasColor: snowColor,
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: bgColor,
    canvasColor: secondaryColor,
  );
}
