import 'package:flutter/material.dart';

import '../../values/app_text_styles.dart';
import '../asterisk.dart';

class MyFormSwitch extends StatelessWidget {

  final String label;
  final bool? value;
  final Function(bool value) onChange;
  final bool required;
  final bool readOnly;

  const MyFormSwitch({
    super.key,
    required this.label,
    this.value = true,
    required this.onChange,
    this.required = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (required) const Asterisk(),
          Text(label, style: readOnly ? AppTextStyle.formReadOnlyLabelStyle : AppTextStyle.formLabelStyle),
          const SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Switch(
                value: value ?? true,
                onChanged: readOnly ? null : (value) => onChange(value),
              ),
            )
          )
        ]
    );
  }
}
