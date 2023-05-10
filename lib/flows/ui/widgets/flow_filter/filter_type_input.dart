import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterTypeInput extends StatelessWidget {

  const FilterTypeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterSelect(
      name: 'type',
      label: '交易类型',
      options: [
        { 'value': 'EXPENSE', 'label': '支出' },
        { 'value': 'INCOME', 'label': '收入' },
        { 'value': 'TRANSFER', 'label': '转账' },
        { 'value': 'ADJUST', 'label': '余额调整' },
      ],
    );
  }

}
