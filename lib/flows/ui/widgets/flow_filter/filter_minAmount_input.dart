import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterMinAmountInput extends StatelessWidget {

  const FilterMinAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListFilterText(
      label: '起始金额',
      name: 'minAmount',
    );
  }

}


