import '/exports/exports.dart';

class OnlineCheckerController extends Cubit<bool> {
  //
  OnlineCheckerController() : super(online);
  static bool online = false;
  // mutations
  void updateChecker(bool online) => emit(online);
}
