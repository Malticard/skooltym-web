import '/exports/exports.dart';

/// {@template brightness_cubit}
/// A simple [Cubit] that manages the [ThemeData] as its state.
/// {@endtemplate}
class ThemeController extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeController() : super(_light);

  // light theme
  static final _light = Themes.lightTheme;
  // dark theme
  static final _dark = Themes.darkTheme;

  /// Toggles the current brightness between light and dark.
  void toggleDarkLightTheme() =>
      emit(state.brightness == Brightness.dark ? _light : _dark);

  // void applyTheme(ThemeData them) => emit(them);
}
