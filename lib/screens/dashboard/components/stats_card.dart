import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:malubullule/constants.dart';
import 'package:malubullule/providers/drink_stats_provider.dart';
import 'package:provider/provider.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<DrinkStatsProvider>().getDrinks(),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.alcoholLevelText,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  context.watch<DrinkStatsProvider>().getAlcoholLevel() + 'g/L',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  AppLocalizations.of(context)!.alcoholAbsorbedText,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  context.watch<DrinkStatsProvider>().getAlcoholAbsorbed() +
                      'g',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  AppLocalizations.of(context)!.estimatedTimeText,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  context.watch<DrinkStatsProvider>().getEstimatedTime(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  TextFormField weightField(
      AsyncSnapshot<int> projectSnap, BuildContext context) {
    return TextFormField(
      initialValue: projectSnap.data.toString(),
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.weightCardLabelText,
        helperText: AppLocalizations.of(context)!.weightCardHelperText,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        if (value != "") {
          context.read<DrinkStatsProvider>().updateWeight(int.parse(value));
        }
      },
    );
  }
}
