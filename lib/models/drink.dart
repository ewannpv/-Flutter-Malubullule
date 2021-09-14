import 'package:uuid/uuid.dart';

class Drink {
  final String? name;
  final int? volume, date;
  final double? abv;
  final List<String>? categories;
  final String id = getRandomId();
  Drink({this.name, this.abv, this.volume, this.date, this.categories});
}

// Returns a random id.
String getRandomId() {
  Uuid uuid = const Uuid();
  return uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
}

List demoDrinks = [
  Drink(
      name: "86 Original",
      abv: 8.6,
      volume: 50,
      date: 15,
      categories: ["beer", "classic"]),
  Drink(
      name: "86 Original",
      abv: 8.6,
      volume: 50,
      date: 15,
      categories: ["beer", "classic"]),
  Drink(
      name: "86 Original",
      abv: 8.6,
      volume: 50,
      date: 15,
      categories: ["beer", "classic"]),
  Drink(
      name: "86 Original",
      abv: 8.6,
      volume: 50,
      date: 15,
      categories: ["beer", "classic"]),
  Drink(
      name: "86 Original",
      abv: 8.6,
      volume: 50,
      date: 15,
      categories: ["beer", "classic"]),
  Drink(
      name: "86 Original",
      abv: 8.6,
      volume: 50,
      date: 15,
      categories: ["beer", "classic"]),
  Drink(
      name: "86 Original",
      abv: 8.6,
      volume: 50,
      date: 15,
      categories: ["beer", "classic"]),
];
