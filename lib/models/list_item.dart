import 'package:flutter/material.dart';

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
  List<DropdownMenuItem<ListItem>> items = [];
  for (ListItem listItem in listItems) {
    items.add(
      DropdownMenuItem(
        child: Text(listItem.name),
        value: listItem,
      ),
    );
  }
  return items;
}
