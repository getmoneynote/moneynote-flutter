import 'package:flutter/material.dart';
import '/commons/index.dart';

class FilterBookInput extends StatelessWidget {

  const FilterBookInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListFilterSelect(
      prefix: 'books',
      name: 'book',
      label: '所属账本',
    );
  }

}



