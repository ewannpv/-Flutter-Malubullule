import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:malubullule/constants.dart';
import 'package:malubullule/models/list_item.dart';
import 'package:malubullule/providers/options_provider.dart';
import 'package:provider/provider.dart';

class GenderCard extends StatelessWidget {
  final List<ListItem> _dropdownItems = [
    ListItem(1, "Male"),
    ListItem(2, "Female"),
  ];

  GenderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<ListItem>> _dropdownMenuItems =
        buildDropDownMenuItems(_dropdownItems);

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
                DropdownButtonFormField<ListItem>(
                    value: _dropdownMenuItems[index].value,
                    items: _dropdownMenuItems,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.genderCardLabelText,
                      helperText:
                          AppLocalizations.of(context)!.genderCardHelperText,
                    ),
                    onChanged: (value) {
                      int gender = _dropdownItems.indexOf(value!);
                      context.read<OptionsProvider>().updateGender(gender);
                    }),
              ],
            ),
          );
        }
      },
    );
  }
}
