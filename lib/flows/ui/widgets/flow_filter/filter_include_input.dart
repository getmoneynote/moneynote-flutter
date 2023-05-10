import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterIncludeInput extends StatelessWidget {

  const FilterIncludeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterSelect(
      name: 'include',
      label: '是否确认',
      options: [
        { 'value': true, 'label': '是' },
        { 'value': false, 'label': '否' },
      ],
    );
  }

}


