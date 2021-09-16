import 'package:flutter/material.dart';
import 'package:malubullule/fetchers/fetch_categories.dart';
import 'package:malubullule/fetchers/fetch_drinks.dart';
import 'package:malubullule/models/drink_category.dart';
import 'package:malubullule/models/drink.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDrinksProvider extends ChangeNotifier {
  List<Drink> _drinks = [];
  List<DrinkCategory> _categories = [];
  List<Drink> _displayedDrinks = [];

  List<DropdownMenuItem<String>> displayedDrinks = [];
  List<DropdownMenuItem<String>> displayedCategories = [];

  Drink? selectedDrink;
  DrinkCategory? selectedCategory;
  int selectedVolume = 0;

  Drink generateDrink() {
    Drink generartedDrink = selectedDrink!;
    generartedDrink.date = 99;
    return generartedDrink;
  }

  Future<List<DropdownMenuItem<String>>> updateCatalog() async {
    await _getCategories();
    await _getDrinks();

    displayedCategories = _categories
        .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
              value: e.displayedName,
              child: Text(e.displayedName!),
            ))
        .toList();

    if (displayedDrinks.isEmpty) {
      updateSelectedCategory(_categories[0].displayedName!);
    }
    return displayedDrinks;
  }

  void updateSelectedCategory(String category) {
    selectedCategory =
        _categories.firstWhere((element) => element.displayedName == category);

    if (selectedCategory!.name == 'custom') {
      _displayedDrinks = Drink.getCustomDrinks();
    } else {
      _displayedDrinks = _drinks
          .where(
              (element) => element.categories!.contains(selectedCategory!.name))
          .toList();
    }
    selectedDrink = _displayedDrinks[0];
    selectedVolume = selectedDrink!.volume!;
    displayedDrinks = _displayedDrinks
        .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
              value: e.name,
              child: Text(e.name!),
            ))
        .toList();
    notifyListeners();
  }

  void updateSelectedDrink(String drink) {
    selectedDrink = _drinks.firstWhere((element) => element.name == drink);
    selectedVolume = selectedDrink!.volume!;
    notifyListeners();
  }

  void updateSelectedVolume(int volume) {
    selectedVolume = volume;
    notifyListeners();
  }

  String getSelectedVolume() {
    return selectedVolume.toString();
  }

  Future<List<Drink>> _getDrinks() async {
    if (_drinks.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('drinks_catalog')) {
        String? drinksData = prefs.getString('drinks_catalog');
        _drinks = Drink.decode(drinksData!)!;
      } else {
        _drinks = await fetchDrinks();
      }
    }
    return _drinks;
  }

  Future<List<DrinkCategory>> _getCategories() async {
    if (_categories.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('categories_catalog')) {
        String? categoriesData = prefs.getString('categories_catalog');
        _categories = DrinkCategory.decode(categoriesData!)!;
      } else {
        _categories = await fetchCategories();
      }
    }
    return _categories;
  }
}
