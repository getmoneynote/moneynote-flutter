import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterNotesInput extends StatelessWidget {

  const FilterNotesInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterText(
      label: '备注',
      name: 'notes',
    );
  }

}


