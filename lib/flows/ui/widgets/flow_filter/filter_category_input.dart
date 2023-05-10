import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';

class FilterCategoryInput extends StatelessWidget {

  const FilterCategoryInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListPageBloc, ListPageState>(
      buildWhen: (previous, current) => previous.query['book'] != current.query['book'] || previous.query['type'] != current.query['type'],
      builder: (context, state) {
        dynamic book = state.query['book'];
        String? type = state.query['type'];
        bool isEmpty = type == 'TRANSFER' || type == 'ADJUST';
        return ListFilterTreeSelect(
          key: UniqueKey(),
          multiple: true,
          prefix: isEmpty ? null : 'categories',
          query: {
            'bookId': book,
            'type': type,
          },
          name: 'categories',
          label: '类别',
        );
      }
    );
  }

}



