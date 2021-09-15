import 'package:flutter/material.dart';
import 'package:malubullule/models/drink.dart';
import 'package:malubullule/providers/drinks_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class AddDrink extends StatelessWidget {
  const AddDrink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: defaultPadding),
      height: 400,
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<DrinksProvider>().addDrink(Drink(
                      name: 'test',
                      abv: 5.5,
                      volume: 50,
                      date: 45,
                      categories: []));
                },
                child: const Text("test"),
              )
            ],
          )
        ],
      ),
    );
  }
}
