import 'package:flutter/material.dart';
import 'package:malubullule/models/drink.dart';
import 'package:malubullule/models/drink_category.dart';
import 'package:malubullule/providers/add_drinks_provider.dart';
import 'package:malubullule/providers/drinks_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants.dart';

class AddDrink extends StatelessWidget {
  const AddDrink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddDrinksProvider(),
        ),
      ],
      child: const _AddDrink(),
    );
  }
}

class _AddDrink extends StatelessWidget {
  const _AddDrink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 400,
      child: Column(
        children: [
          FutureBuilder(
            future: context.watch<AddDrinksProvider>().updateCatalog(),
            builder: (context, projectSnap) {
              if (projectSnap.connectionState == ConnectionState.none ||
                  !projectSnap.hasData) {
                //print('project snapshot data is: ${projectSnap.data}');
                return Container();
              } else {
                return Column(children: [
                  DropdownButtonFormField<String>(
                      value: context
                          .watch<AddDrinksProvider>()
                          .selectedCategory!
                          .displayedName,
                      items: context
                          .watch<AddDrinksProvider>()
                          .displayedCategories,
                      decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.addDrinkDrinkText),
                      onChanged: (value) {
                        context
                            .read<AddDrinksProvider>()
                            .updateSelectedCategory(value!);
                      }),
                  DropdownButtonFormField<String>(
                      value: context
                          .watch<AddDrinksProvider>()
                          .selectedDrink!
                          .name,
                      items: context.watch<AddDrinksProvider>().displayedDrinks,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.addDrinkDrinkText,
                      ),
                      onChanged: (value) {
                        context
                            .watch<AddDrinksProvider>()
                            .updateSelectedDrink(value!);
                      }),
                ]);
              }
            },
          ),
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
