import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterMaxTimeInput extends StatelessWidget {

  const FilterMaxTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterDate(
      label: '终止日期',
      name: 'maxTime',
    );
  }

}


