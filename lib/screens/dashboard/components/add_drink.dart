import 'package:flutter/material.dart';
import 'package:malubullule/models/drink.dart';
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
          FutureBuilder<List<Drink>>(
              future: context.watch<AddDrinksProvider>().getDrinks(),
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none ||
                    !projectSnap.hasData) {
                  //print('project snapshot data is: ${projectSnap.data}');
                  return Container();
                } else {
                  List<DropdownMenuItem<String>> items = projectSnap.data!
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem<String>(
                                value: e.name,
                                child: Text(e.name!),
                              ))
                      .toList();
                  return DropdownButtonFormField<String>(
                      value: items[0].value,
                      items: items,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.genderCardLabelText,
                        helperText:
                            AppLocalizations.of(context)!.genderCardHelperText,
                      ),
                      onChanged: (value) {});
                }
              }),
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
