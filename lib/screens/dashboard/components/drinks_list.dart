import 'package:malubullule/models/drink.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
                  "drinks list",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
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
              demoDrinks.length,
              (index) => drinksDataRow(demoDrinks[index]),
            ),
          ),
        ],
      ),
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
        drinkInfo.abv!,
        maxLines: 2,
      )),
      DataCell(AutoSizeText(
        drinkInfo.date!,
        maxLines: 2,
      )),
    ],
  );
}
