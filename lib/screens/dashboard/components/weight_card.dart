import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constants.dart';

class WeightCard extends StatelessWidget {
  const WeightCard({
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            initialValue: '70',
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.weightCardLabelText,
              helperText: AppLocalizations.of(context)!.weightCardHelperText,
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
