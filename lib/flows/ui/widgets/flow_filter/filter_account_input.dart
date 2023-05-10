import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterAccountInput extends StatelessWidget {

  const FilterAccountInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListFilterSelect(
      prefix: 'accounts',
      name: 'account',
      label: '账户',
    );
  }

}


