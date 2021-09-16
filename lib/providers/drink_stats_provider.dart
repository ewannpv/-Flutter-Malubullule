import 'package:flutter/material.dart';
import 'package:malubullule/fetchers/fetch_drinks.dart';
import 'package:malubullule/models/drink.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrinkStatsProvider extends ChangeNotifier {
  List<Drink> _drinks = [];
  double _alcoholAbsorbed = 0;
  double _alcoholLevel = 0;
  int _gender = -1; // 0: male, 0: female.
  int _weight = -1;

  String getEstimatedTime() {
    // Homme : 0,10g/L à 0,15g/L par heure,
    // Femme : 0,085g/L à 0,10g/L par heure.
    double eliminationSpeed = _gender == 0 ? 0.125 : 0.092;
    eliminationSpeed /= 60;
    int minutes = 0;
    double tmp = _alcoholLevel;
    for (minutes; tmp > 0.5; minutes += 1) {
      tmp -= eliminationSpeed;
    }
    final int hour = minutes ~/ 60;
    minutes = minutes % 60;
    return '${hour.toString().padLeft(2, "0")}h${minutes.toString().padLeft(2, "0")}min';
  }

  String getAlcoholLevel() {
    double diffusionCoef = _gender == 0 ? 0.7 : 0.6;
    _alcoholLevel = (_alcoholAbsorbed / (_weight * diffusionCoef));
    return _alcoholLevel.toStringAsFixed(4);
  }

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

  Future<void> updateCatalog() async {
    fetchDrinks();
    fetchDrinks();
  }

  String getAlcoholAbsorbed() {
    double value = 0;
    for (var element in _drinks) {
      value += element.alcoholAbsorbed();
    }
    _alcoholAbsorbed = value;
    return value.toString();
  }

  Future<List<Drink>> getDrinks() async {
    if (_drinks.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('drinks_list')) {
        String? drinksData = prefs.getString('drinks_list');
        _drinks = Drink.decode(drinksData!)!;
      }
    }
    return _drinks;
  }

  void updateDrinkList(List<Drink> newList) {
    _drinks = newList;
    notifyListeners();
  }

  Future<void> addDrink(Drink newDrink) async {
    _drinks.add(newDrink);
    _drinks.sort((b, a) => a.date!.compareTo(b.date!));

    String drinksData = Drink.encode(_drinks);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('drinks_list', drinksData);
    notifyListeners();
  }

  Future<void> removeDrinkWithId(String id) async {
    int index = _drinks.indexWhere((element) => element.id == id);
    _drinks.removeAt(index);
    String drinksData = Drink.encode(_drinks);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('drinks_list', drinksData);
    notifyListeners();
  }
}
