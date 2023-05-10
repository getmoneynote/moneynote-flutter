import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterMinTimeInput extends StatelessWidget {

  const FilterMinTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterDate(
      label: '起始日期',
      name: 'minTime',
    );
  }

}


