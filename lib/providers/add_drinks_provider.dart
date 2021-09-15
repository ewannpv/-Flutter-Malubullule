import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:malubullule/models/drink_category.dart';
import 'package:malubullule/models/drink.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class AddDrinksProvider extends ChangeNotifier {
  final String _categoriesURL =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vRB--rin5NSwuZmC22WhPbkKquV2HLrJ_RwGdSvFLtZd93hP-1e8A9Dfo3h6FQAQLHKYSZwpxyz2Tmz/pub?gid=1842611777&single=true&output=csv';
  final String _drinksURL =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vRB--rin5NSwuZmC22WhPbkKquV2HLrJ_RwGdSvFLtZd93hP-1e8A9Dfo3h6FQAQLHKYSZwpxyz2Tmz/pub?gid=1048684850&single=true&output=csv';

  List<Drink> _drinks = [];
  List<DrinkCategory> _categories = [];
  List<Drink> _displayedDrinks = [];

  List<DropdownMenuItem<String>> displayedDrinks = [];
  List<DropdownMenuItem<String>> displayedCategories = [];

  Drink? selectedDrink;
  DrinkCategory? selectedCategory;

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

  Future<void> updateSelectedCategory(String category) async {
    selectedCategory =
        _categories.firstWhere((element) => element.displayedName == category);
    _displayedDrinks = _drinks
        .where(
            (element) => element.categories!.contains(selectedCategory!.name))
        .toList();
    selectedDrink = _displayedDrinks[0];
    displayedDrinks = _displayedDrinks
        .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
              value: e.name,
              child: Text(e.name!),
            ))
        .toList();
    notifyListeners();
  }

  Future<void> updateSelectedDrink(String drink) async {
    selectedDrink = _drinks.firstWhere((element) => element.name == drink);
    notifyListeners();
  }

  Future<List<Drink>> _getDrinks() async {
    if (_drinks.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('drinks_catalog')) {
        String? drinksData = prefs.getString('drinks_catalog');
        _drinks = Drink.decode(drinksData!)!;
      } else {
        _fetchDrinks();
      }
    }
    return _drinks;
  }

  Future<void> _fetchDrinks() async {
    Uri url = Uri.parse(_drinksURL);
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter().convert(response.body);
      rowsAsListOfValues.removeAt(0);
      for (var row in rowsAsListOfValues) {
        String name = row[0];
        double abv = row[1].toDouble();
        int volume = row[2];
        List categories = [];
        for (int i = 3; i <= 7; i += 1) {
          String category = row[i];
          if (category.isEmpty) {
            break;
          }
          categories.add(category);
        }
        Drink drink = Drink(
            name: name,
            abv: abv,
            volume: volume,
            date: 0,
            categories: categories);
        _drinks.add(drink);
      }
      _updateDrinks();
    }
  }

  Future<void> _updateDrinks() async {
    String drinksData = Drink.encode(_drinks);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('drinks_catalog', drinksData);
  }

  Future<List<DrinkCategory>> _getCategories() async {
    if (_categories.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('categories_catalog')) {
        String? categoriesData = prefs.getString('categories_catalog');
        _categories = DrinkCategory.decode(categoriesData!)!;
      } else {
        _fetchCategories();
      }
    }
    return _categories;
  }

  Future<void> _fetchCategories() async {
    Uri url = Uri.parse(_categoriesURL);
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter().convert(response.body);
      rowsAsListOfValues.removeAt(0);
      for (var row in rowsAsListOfValues) {
        String name = row[0];
        String displayedName = row[1];
        DrinkCategory category =
            DrinkCategory(name: name, displayedName: displayedName);
        _categories.add(category);
      }
      _updateCategories();
    }
  }

  Future<void> _updateCategories() async {
    String categoriesData = DrinkCategory.encode(_categories);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('categories_catalog', categoriesData);
  }
}
