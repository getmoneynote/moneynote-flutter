import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/charts/index.dart';

class FilterTagInput extends StatefulWidget {

  const FilterTagInput({
    super.key,
  });

  @override
  State<FilterTagInput> createState() => _FilterTagInputState();
}

class _FilterTagInputState extends State<FilterTagInput> {

  Map<String, dynamic> _buildQuery(ChartExpenseCategoryState state) {
    Map<String, dynamic> query = {
      'bookId': state.query['bookId'],
      'canExpense': true,
    };
    return query;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
        prefix: 'tags',
        query: _buildQuery(context.read<ChartExpenseCategoryBloc>().state)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['tags'] ?? const SelectOptionsModel();
    return BlocConsumer<ChartExpenseCategoryBloc, ChartExpenseCategoryState>(
        listenWhen: (previous, current) => previous.query['bookId'] != current.query['bookId'],
        listener: (context, state) {
          BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
              prefix: 'tags',
              query: _buildQuery(state)
          ));
        },
        buildWhen: (previous, current) => previous.query['tags'] != current.query['tags'],
        builder: (context, state) {
          return MyTreeSelect(
            multiple: true,
            label: '支出标签',
            options: optionModel.options,
            value: state.query['tags'],
            onChange: (value) {
              context.read<ChartExpenseCategoryBloc>().add(ChartExpenseCategoryQueryChanged({ 'tags': value }));
            },
            loading: optionModel.status != LoadDataStatus.success,
          );
        }
    );
  }

}




