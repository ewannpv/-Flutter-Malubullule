import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:malubullule/providers/options_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class WeightCard extends StatelessWidget {
  const WeightCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: context.watch<OptionsProvider>().getGWeight(),
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
                TextFormField(
                  initialValue: projectSnap.data.toString(),
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.weightCardLabelText,
                    helperText:
                        AppLocalizations.of(context)!.weightCardHelperText,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value != "") {
                      context
                          .read<OptionsProvider>()
                          .updateWeight(int.parse(value));
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
