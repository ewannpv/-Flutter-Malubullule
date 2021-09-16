import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _AddDrink extends StatefulWidget {
  const _AddDrink({Key? key}) : super(key: key);

  @override
  _AddDrinkState createState() => _AddDrinkState();
}

class _AddDrinkState extends State<_AddDrink> {
  late TextEditingController _volumeTextController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _volumeTextController = TextEditingController(
        text: context.watch<AddDrinksProvider>().getSelectedVolume());
  }

  @override
  void dispose() {
    _volumeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
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
                  categoryField(context),
                  const SizedBox(height: defaultPadding),
                  drinkField(context),
                  const SizedBox(height: defaultPadding),
                  volumetField(context),
                  const SizedBox(height: defaultPadding * 2),
                  addButton(context),
                ]);
              }
            },
          ),
        ],
      ),
    );
  }

  Row addButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              Drink newDrink =
                  context.read<AddDrinksProvider>().generateDrink();
              context.read<DrinksProvider>().addDrink(newDrink);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 22),
                minimumSize: const Size(0, 50)),
            child:
                Text(AppLocalizations.of(context)!.addDrinkConfirmationButton),
          ),
        ),
      ],
    );
  }

  DropdownButtonFormField<String> drinkField(BuildContext context) {
    return DropdownButtonFormField<String>(
        value: context.watch<AddDrinksProvider>().selectedDrink!.name,
        items: context.watch<AddDrinksProvider>().displayedDrinks,
        decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.addDrinkDrinkText,
            helperText:
                '${context.watch<AddDrinksProvider>().selectedDrink!.name}, ${context.watch<AddDrinksProvider>().selectedDrink!.abv}%'),
        onChanged: (value) {
          context.read<AddDrinksProvider>().updateSelectedDrink(value!);
        });
  }

  DropdownButtonFormField<String> categoryField(BuildContext context) {
    return DropdownButtonFormField<String>(
        value:
            context.watch<AddDrinksProvider>().selectedCategory!.displayedName,
        items: context.watch<AddDrinksProvider>().displayedCategories,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.addDrinkCategoryText,
        ),
        onChanged: (value) {
          context.read<AddDrinksProvider>().updateSelectedCategory(value!);
        });
  }

  TextFormField volumetField(BuildContext context) {
    return TextFormField(
      controller: _volumeTextController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.addDrinkVolumeText,
        helperText: AppLocalizations.of(context)!.addDrinkVolumeTextHelper,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        if (value != "") {
          context
              .read<AddDrinksProvider>()
              .updateSelectedVolume(int.parse(value));
        }
      },
    );
  }
}
