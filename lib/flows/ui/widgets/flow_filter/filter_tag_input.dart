import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';

class FilterTagInput extends StatelessWidget {

  const FilterTagInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListPageBloc, ListPageState>(
      buildWhen: (previous, current) => previous.query['book'] != current.query['book'] || previous.query['type'] != current.query['type'],
      builder: (context, state) {
        dynamic book = state.query['book'];
        String? type = state.query['type'];
        bool isEmpty = type == 'ADJUST';
        Map<String, dynamic> query = { 'bookId': book };
        if (type == 'EXPENSE') {
          query = { ...query, 'canExpense': true };
        }
        if (type == 'INCOME') {
          query = { ...query, 'canIncome': true };
        }
        if (type == 'TRANSFER') {
          query = { ...query, 'canTransfer': true };
        }
        return ListFilterTreeSelect(
          key: UniqueKey(),
          multiple: true,
          prefix: isEmpty ? null : 'tags',
          query: query,
          name: 'tags',
          label: '标签',
        );
      }
    );
  }

}



