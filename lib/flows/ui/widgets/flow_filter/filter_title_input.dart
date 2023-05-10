import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterTitleInput extends StatelessWidget {

  const FilterTitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterText(
      label: '标题',
      name: 'title',
    );
  }

}


