import 'dart:convert';

import 'package:uuid/uuid.dart';

class DrinkCategory {
  final String? name, displayedName;
  final String id = DrinkCategory._getRandomId();
  DrinkCategory({this.name, this.displayedName});

// Returns a random id.
  static String _getRandomId() {
    Uuid uuid = const Uuid();
    return uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
  }

  factory DrinkCategory.fromJson(Map<String, dynamic> jsonData) {
    return DrinkCategory(
      name: jsonData['name'],
      displayedName: jsonData['displayedName'],
    );
  }

  static Map<String, dynamic> toMap(DrinkCategory drink) => {
        'name': drink.name,
        'displayedName': drink.displayedName,
      };

  static String encode(List<DrinkCategory> drinks) => json.encode(
        drinks
            .map<Map<String, dynamic>>((drink) => DrinkCategory.toMap(drink))
            .toList(),
      );

  static List<DrinkCategory>? decode(String drinks) =>
      (json.decode(drinks) as List<dynamic>)
          .map<DrinkCategory>((item) => DrinkCategory.fromJson(item))
          .toList();
}
