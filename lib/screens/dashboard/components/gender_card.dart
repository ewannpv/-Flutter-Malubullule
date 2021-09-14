import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:malubullule/models/list_item.dart';
import '../../../constants.dart';

class GenderCard extends StatefulWidget {
  const GenderCard({Key? key}) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  final List<ListItem> _dropdownItems = [
    ListItem(1, "Male"),
    ListItem(2, "Female"),
  ];
  late List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  late ListItem _selectedItem;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value!;
    log("done");
  }

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
          DropdownButtonFormField<ListItem>(
              value: _selectedItem,
              items: _dropdownMenuItems,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.genderCardLabelText,
                helperText: AppLocalizations.of(context)!.genderCardHelperText,
              ),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value!;
                });
              }),
        ],
      ),
    );
  }
}
