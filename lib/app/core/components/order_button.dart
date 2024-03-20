import 'package:flutter/material.dart';
import 'popup_menu.dart';


class OrderButton extends StatelessWidget {

  const OrderButton({
    super.key,
    required this.items,
    required this.onSelected,
    required this.selected,
  });

  final Map<String, String> items;
  final Function onSelected;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return PopupMenu(
      onSelected: (selected) {
        onSelected.call(selected);
      },
      items: items,
      selected: selected,
    );
  }

}