import 'package:malubullule/models/drink.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:malubullule/providers/drinks_provider.dart';
import 'package:malubullule/screens/dashboard/components/add_drink.dart';
import '../../../constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DrinksList extends StatelessWidget {
  const DrinksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.drinkListTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final drinksProvider =
                      Provider.of<DrinksProvider>(context, listen: false);

                  presentAddDrinkSheet(context, drinksProvider);
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
          DataTable2(
            columnSpacing: defaultPadding,
            horizontalMargin: defaultPadding,
            columns: const [
              DataColumn(
                label: Text("Name"),
              ),
              DataColumn(
                label: Text("Volume"),
              ),
              DataColumn(
                label: Text("Date"),
              ),
            ],
            rows: List.generate(
              context.watch<DrinksProvider>().getDrinks().length,
              (index) => drinksDataRow(
                  context.watch<DrinksProvider>().getDrinks()[index]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> presentAddDrinkSheet(
      BuildContext context, DrinksProvider drinksProvider) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      context: context,
      builder: (BuildContext context) {
        return ListenableProvider.value(
          value: drinksProvider,
          child: const AddDrink(),
        );
      },
    );
  }
}

DataRow drinksDataRow(Drink drinkInfo) {
  return DataRow(
    cells: [
      DataCell(AutoSizeText(
        drinkInfo.name!,
        maxLines: 2,
      )),
      DataCell(AutoSizeText(
        drinkInfo.abv.toString(),
        maxLines: 2,
      )),
      DataCell(AutoSizeText(
        drinkInfo.date.toString(),
        maxLines: 2,
      )),
    ],
  );
}
