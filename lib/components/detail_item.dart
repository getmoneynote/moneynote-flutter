import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {

  const DetailItem({
    super.key,
    required this.label,
    this.value,
    this.space = true,
    this.tail,
    this.crossAlign = CrossAxisAlignment.center,
  });

  final String label;
  final String? value;
  final bool space;
  final Widget? tail;
  final CrossAxisAlignment crossAlign;

  @override
  Widget build(BuildContext context) {
    TextStyle? style1 = Theme.of(context).textTheme.bodyMedium;
    TextStyle? style2 = Theme.of(context).textTheme.bodyLarge;
    final Widget row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAlign,
      children: [
        Text(label, style: style1),
        Flexible(child: Text(value ?? '', style: style2)),
        const SizedBox(width: 10),
        if (tail != null) tail!,
      ]
    );
    if (space) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: row,
      );
    } else {
      return row;
    }
  }

}
