import 'package:flutter/material.dart';
import 'package:malubullule/fetchers/fetch_drinks.dart';
import 'package:malubullule/models/drink.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrinksProvider extends ChangeNotifier {
  List<Drink> drinks = [];

  Future<void> updateCatalog() async {
    fetchDrinks();
    fetchDrinks();
  }

  Future<List<Drink>> getDrinks() async {
    if (drinks.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('drinks_list')) {
        String? drinksData = prefs.getString('drinks_list');
        drinks = Drink.decode(drinksData!)!;
      }
    }
    return drinks;
  }

  void updateDrinkList(List<Drink> newList) {
    drinks = newList;
    notifyListeners();
  }

  Future<void> addDrink(Drink newDrink) async {
    drinks.add(newDrink);
    drinks.sort((b, a) => a.date!.compareTo(b.date!));

    String drinksData = Drink.encode(drinks);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('drinks_list', drinksData);
    notifyListeners();
  }

  Future<void> removeDrinkWithId(String id) async {
    int index = drinks.indexWhere((element) => element.id == id);
    drinks.removeAt(index);
    String drinksData = Drink.encode(drinks);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('drinks_list', drinksData);
    notifyListeners();
  }
}
