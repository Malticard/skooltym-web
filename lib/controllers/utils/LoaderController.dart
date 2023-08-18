import 'package:flutter/material.dart';

class LoaderController with ChangeNotifier {
  bool _isLoading = false;
  bool _isSavingSetting = false;
  // getters
  bool get isLoading => _isLoading;
  bool get isSavingSetting => _isSavingSetting;
  // end of getters

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setSavingSetting(bool value) {
    _isSavingSetting = value;
    notifyListeners();
  }
}
