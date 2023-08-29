import 'package:flutter/material.dart';

class LoaderController with ChangeNotifier {
  bool _isLoading = false;
  bool _isSavingSetting = false;
  bool _isAddingPayment = false;
  bool _isUpdatingPassword = false;
  // getters
  bool get isLoading => _isLoading;
  bool get isSavingSetting => _isSavingSetting;
  bool get isAddingPayment => _isAddingPayment;
  bool get isUpdatingPassword => _isUpdatingPassword;
  // end of getters

// setters
  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setSavingSetting(bool value) {
    _isSavingSetting = value;
    notifyListeners();
  }

  set setIsAddingPayment(bool value) {
    _isAddingPayment = value;
    notifyListeners();
  }

  set setIsUpdatingPassword(bool v) {
    _isUpdatingPassword = v;
    notifyListeners();
  }
}
