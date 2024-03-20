import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/values/app_text_styles.dart';
import '/generated/locales.g.dart';
import '../../utils/utils.dart';
import '../asterisk.dart';

class MySelect extends StatelessWidget {

  final String label;
  final dynamic value;
  final bool readOnly;
  final bool required;
  final bool allowClear;
  final Function? onClear;
  final Function? onFocus;
  final bool multiple;

  const MySelect({
    super.key,
    required this.label,
    this.value,
    this.readOnly = false,
    this.required = false,
    this.allowClear = false,
    this.onClear,
    this.onFocus,
    this.multiple = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      onTap: readOnly ? null : () {
        if (onFocus != null) {
          onFocus!.call();
        }
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (required) const Asterisk(),
          Text(
            label,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: readOnly ? AppTextStyle.formReadOnlyLabelStyle : AppTextStyle.formLabelStyle,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              labelText(),
              style: readOnly ? AppTextStyle.formReadOnlyLabelStyle : AppTextStyle.formLabelStyle,
              softWrap: true,
            )
          ),
          const Icon(Icons.keyboard_arrow_right),
          if (allowClear && !isNullEmpty(value))
            IconButton(
              onPressed: () {
                onClear?.call();
              },
              icon: const Icon(Icons.backspace)
            )
        ],
      ),
    );
  }

  String labelText() {
    if (multiple) {
      if (value?.isEmpty ?? true) {
        return LocaleKeys.form_selectPlaceholder1.tr;
      } else {
        return value.map((e) => e['label']).toList().join(', ');
      }

    } else {
      return value?['label'] ?? LocaleKeys.form_selectPlaceholder2.tr;
    }
  }

}