import 'package:flutter/material.dart';

class MyAuthFormController extends ChangeNotifier {
  String _userName = "";
  String _email = "";
  String _password = "";
  bool _togglePassword = true;
  String _doctorId = ""; // New variable

  String get userName => _userName;
  String get email => _email;
  String get password => _password;
  bool get togglePassword => _togglePassword;
  String get doctorId => _doctorId; // Getter for doctorId

  void setEmailField(String value) {
    _email = value;
    notifyListeners();
  }

  void setUserNameField(String value) {
    _userName = value;
    notifyListeners();
  }

  void setPasswordField(String value) {
    _password = value;
    notifyListeners();
  }

  void togglePasswordIcon() {
    _togglePassword = !_togglePassword;
    notifyListeners();
  }

  // New method to set doctorId
  void setDoctorId(String value) {
    _doctorId = value;
    notifyListeners();
  }
}
