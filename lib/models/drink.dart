import 'dart:convert';

import 'package:uuid/uuid.dart';

class Drink {
  final String? name;
  final int? volume;
  int? date;
  final double? abv;
  final List? categories;
  final String id = Drink._getRandomId();
  Drink({this.name, this.abv, this.volume, this.date, this.categories});

  double alcoholAbsorbed() {
    if (abv == 0 || volume == 0) return 0;
    // 1L of alcohol = 800g.
    return abv! * (volume! / 100) * 8;
  }

// Returns a random id.
  static String _getRandomId() {
    Uuid uuid = const Uuid();
    return uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
  }

  factory Drink.fromJson(Map<String, dynamic> jsonData) {
    return Drink(
      name: jsonData['name'],
      abv: jsonData['abv'],
      volume: jsonData['volume'],
      date: jsonData['date'],
      categories: jsonData['categories'],
    );
  }

  static Map<String, dynamic> toMap(Drink drink) => {
        'name': drink.name,
        'abv': drink.abv,
        'volume': drink.volume,
        'date': drink.date,
        'categories': drink.categories,
      };

  static String encode(List<Drink> drinks) => json.encode(
        drinks
            .map<Map<String, dynamic>>((drink) => Drink.toMap(drink))
            .toList(),
      );

  static List<Drink>? decode(String drinks) =>
      (json.decode(drinks) as List<dynamic>)
          .map<Drink>((item) => Drink.fromJson(item))
          .toList();

  static List<Drink> getCustomDrinks() {
    List<Drink> drinks = [];
    for (int index = 1; index <= 100; index += 1) {
      String name = 'Brevage à ${index.toString()}°';
      drinks.add(Drink(
          name: name,
          abv: index.toDouble(),
          volume: 5,
          date: 0,
          categories: ['custom']));
    }
    return drinks;
  }
}
