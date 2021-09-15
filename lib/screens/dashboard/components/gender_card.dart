import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:malubullule/constants.dart';
import 'package:malubullule/providers/options_provider.dart';
import 'package:provider/provider.dart';

class GenderCard extends StatelessWidget {
  final List<DropdownMenuItem<String>> _items = ["Male", "Female"]
      .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();
  GenderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: context.watch<OptionsProvider>().getGender(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none ||
            !projectSnap.hasData) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        } else {
          int index = projectSnap.data!;
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
                DropdownButtonFormField<String>(
                  value: _items[index].value,
                  items: _items,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.genderCardLabelText,
                    helperText:
                        AppLocalizations.of(context)!.genderCardHelperText,
                  ),
                  onChanged: (value) {
                    int gender =
                        _items.indexWhere((element) => element.value == value);
                    context.read<OptionsProvider>().updateGender(gender);
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
