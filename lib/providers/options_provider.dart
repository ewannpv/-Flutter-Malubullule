import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsProvider extends ChangeNotifier {
  int _gender = -1; // 0: male, 0: female.
  int _weight = -1;

  Future<int> getGender() async {
    if (_gender < 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('gender')) prefs.setInt('gender', 0);
      _gender = prefs.getInt('gender')!;
    }
    return _gender;
  }

  Future<void> updateGender(int value) async {
    _gender = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('gender', value);
    notifyListeners();
  }

  Future<int> getGWeight() async {
    if (_weight < 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('weight')) prefs.setInt('weight', 70);
      _weight = prefs.getInt('weight')!;
    }
    return _weight;
  }

  Future<void> updateWeight(int value) async {
    _weight = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('weight', value);
    notifyListeners();
  }
}
