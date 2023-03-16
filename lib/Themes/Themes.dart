import '../exports/exports.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: creamColor,
      canvasColor: snowColor,
      brightness: Brightness.light);
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: bgColor,
      canvasColor: secondaryColor,
      brightness: Brightness.dark);
}
