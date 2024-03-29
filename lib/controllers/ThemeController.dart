import '/exports/exports.dart';

/// {@template brightness_cubit}
/// A simple [Cubit] that manages the [ThemeData] as its state.
/// {@endtemplate}
class ThemeController extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeController() : super(_light);

  // light theme
  static final _light = AppThemes.lightTheme;
  // dark theme
  static final _dark = AppThemes.darkTheme;

  // method to keep track of the current brightness between light and dark theme  using shared preferences
  void saveTheme() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(
          'darkTheme', state.brightness == Brightness.dark ? true : false);
    });
  }

  void getTheme() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('darkTheme')) {
        if (prefs.getBool('darkTheme') == true) {
          emit(_dark);
        } else {
          emit(_light);
        }
      }
    });
  }

  /// Toggles the current brightness between light and dark.
  void toggleDarkLightTheme() {
    emit(state.brightness == Brightness.dark ? _light : _dark);
// save the current theme
    saveTheme();
  }

  // method to keep track of the current theme
}
