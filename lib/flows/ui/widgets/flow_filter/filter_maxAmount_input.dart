import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterMaxAmountInput extends StatelessWidget {

  const FilterMaxAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterText(
      label: '终止金额',
      name: 'maxAmount',
    );
  }

}


