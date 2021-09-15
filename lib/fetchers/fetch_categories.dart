import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:malubullule/models/drink_category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const String _categoriesURL =
    'https://docs.google.com/spreadsheets/d/e/2PACX-1vRB--rin5NSwuZmC22WhPbkKquV2HLrJ_RwGdSvFLtZd93hP-1e8A9Dfo3h6FQAQLHKYSZwpxyz2Tmz/pub?gid=1842611777&single=true&output=csv';

Future<List<DrinkCategory>> fetchCategories() async {
  List<DrinkCategory> categories = [];
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
      categories.add(category);
    }
    _updateCategories(categories);
  }
  return categories;
}

Future<void> _updateCategories(List<DrinkCategory> categories) async {
  String categoriesData = DrinkCategory.encode(categories);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('categories_catalog', categoriesData);
}
