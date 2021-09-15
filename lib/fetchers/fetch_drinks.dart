import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:malubullule/models/drink.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const String _drinksURL =
    'https://docs.google.com/spreadsheets/d/e/2PACX-1vRB--rin5NSwuZmC22WhPbkKquV2HLrJ_RwGdSvFLtZd93hP-1e8A9Dfo3h6FQAQLHKYSZwpxyz2Tmz/pub?gid=1048684850&single=true&output=csv';

Future<List<Drink>> fetchDrinks() async {
  List<Drink> drinks = [];
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
      drinks.add(drink);
    }
    _updateDrinks(drinks);
  }
  return drinks;
}

Future<void> _updateDrinks(List<Drink> drinks) async {
  String drinksData = Drink.encode(drinks);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('drinks_catalog', drinksData);
}
