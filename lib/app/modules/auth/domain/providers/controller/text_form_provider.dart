import 'package:flutter/material.dart';

class MyAuthFormController extends ChangeNotifier {
  String _userName = "";
  String _email = "";
  String _password = "";
  late String _docID = "";
  bool _togglePassword = true;
  bool _isDoctor = false; // Add this line

  String get userName => _userName;
  String get email => _email;
  String get password => _password;
  String get docID => _docID;
  bool get togglePassword => _togglePassword;
  bool get isDoctor => _isDoctor; // Add this line

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

  void setIsDoctor(bool value) {
    _isDoctor = value;
    notifyListeners();
  }

  set docID(String value) {
    // Setter for docID
    _docID = value;
    notifyListeners();
  }
}
