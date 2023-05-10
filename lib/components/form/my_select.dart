import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '/commons/index.dart';
import '/components/index.dart';

class MySelect extends StatelessWidget {

  final String label;
  final dynamic value;
  final List<Map<String, dynamic>> options;
  final bool loading;
  final Function? onChange;
  final bool disabled;
  final bool required;
  final bool allowClear;
  final Function? onClear;
  final bool multiple;

  const MySelect({
    super.key,
    required this.label,
    this.value,
    required this.options,
    this.loading = false,
    this.onChange,
    this.disabled = false,
    this.required = false,
    this.allowClear = false,
    this.onClear,
    this.multiple = false,
  });

  @override
  Widget build(BuildContext context) {

    Function selectBuilder = multiple ? SmartSelect<dynamic>.multiple : SmartSelect<dynamic>.single;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (required) const Asterisk(),
        Expanded(
          child: selectBuilder.call(
            title: label,
            placeholder: multiple ? '一个或多个' : '选择一个',
            selectedValue: multiple ? (value ?? []) : value,
            onChange: (selected) => onChange?.call(selected.value),
            choiceItems: S2Choice.listFrom<dynamic, Map<String, dynamic>>(
              source: options,
              value: (_, item) => item['value'],
              title: (_, item) => item['label'],
            ),
            choiceType: S2ChoiceType.chips,
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isLoading: loading,
                enabled: !disabled,
                padding: EdgeInsets.zero,
              );
            }
          )
        ),
        if (allowClear && !isNullEmpty(value))
          IconButton(
            onPressed: () {
              onClear?.call();
            },
            icon:const Icon(Icons.backspace)
          )
      ],
    );
  }

}