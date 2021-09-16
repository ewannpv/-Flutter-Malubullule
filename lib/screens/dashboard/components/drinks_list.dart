import 'package:intl/intl.dart';
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
  build(BuildContext context) {
    return FutureBuilder<List<Drink>>(
      future: context.watch<DrinksProvider>().getDrinks(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none ||
            !projectSnap.hasData) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        } else {
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
                      style: ElevatedButton.styleFrom(primary: bgColor),
                      onPressed: () {
                        final drinksProvider =
                            Provider.of<DrinksProvider>(context, listen: false);
                        presentAddDrinkSheet(context, drinksProvider);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                drinkDataTable(context, projectSnap),
              ],
            ),
          );
        }
      },
    );
  }

  DataTable2 drinkDataTable(
      BuildContext context, AsyncSnapshot<List<Drink>> projectSnap) {
    return DataTable2(
      columnSpacing: defaultPadding,
      horizontalMargin: defaultPadding,
      columns: [
        DataColumn2(
          size: ColumnSize.L,
          label: Text(
            AppLocalizations.of(context)!.drinkListNameText,
          ),
        ),
        DataColumn(
          label: Text(
            AppLocalizations.of(context)!.drinkListAbvText,
          ),
        ),
        DataColumn(
          label: Text(
            AppLocalizations.of(context)!.drinkListVolumeText,
          ),
        ),
        DataColumn(
            label: Text(AppLocalizations.of(context)!.drinkListDateText)),
      ],
      rows: projectSnap.data != null
          ? List.generate(
              projectSnap.data!.length,
              (index) => drinksDataRow(projectSnap.data![index]),
            )
          : List.empty(),
    );
  }

  Future<void> presentAddDrinkSheet(
      BuildContext context, DrinksProvider drinksProvider) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return ListenableProvider.value(
          value: drinksProvider,
          child: Wrap(children: const [AddDrink()]),
        );
      },
    );
  }
}

DataRow drinksDataRow(Drink drinkInfo) {
  String date = DateFormat.Hm()
      .format(DateTime.fromMillisecondsSinceEpoch(drinkInfo.date!));
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
        drinkInfo.volume.toString(),
        maxLines: 2,
      )),
      DataCell(AutoSizeText(
        date,
        maxLines: 2,
      )),
    ],
  );
}
