import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterConfirmInput extends StatelessWidget {

  const FilterConfirmInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterSelect(
      name: 'confirm',
      label: '是否确认',
      options: [
        { 'value': true, 'label': '是' },
        { 'value': false, 'label': '否' },
      ],
    );
  }

}


