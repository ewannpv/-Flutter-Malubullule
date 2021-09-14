import 'package:flutter/material.dart';
import 'package:malubullule/models/drink.dart';

class DrinksProvider extends ChangeNotifier {
  List drinks = List.empty();

  List getDrinks() {
    if (drinks.isEmpty) drinks = demoDrinks;
    return drinks;
  }

  void updateDrinkList(List newList) {
    drinks = newList;
    notifyListeners();
  }

  void addDrink(Drink newDrink) {
    drinks.add(newDrink);
    notifyListeners();
  }

  void removeDrinkWithId(String id) {
    int index = drinks.indexWhere((element) => element.id == id);
    drinks.removeAt(index);
    notifyListeners();
  }
}
