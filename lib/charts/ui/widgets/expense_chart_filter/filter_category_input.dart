import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/charts/index.dart';

class FilterCategoryInput extends StatefulWidget {

  const FilterCategoryInput({
    super.key,
  });

  @override
  State<FilterCategoryInput> createState() => _FilterCategoryInputState();
}

class _FilterCategoryInputState extends State<FilterCategoryInput> {

  Map<String, dynamic> _buildQuery(ChartExpenseCategoryState state) {
    Map<String, dynamic> query = {
      'bookId': state.query['bookId'],
      'type': 'EXPENSE',
    };
    return query;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
        prefix: 'categories',
        query: _buildQuery(context.read<ChartExpenseCategoryBloc>().state)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['categories'] ?? const SelectOptionsModel();
    return BlocConsumer<ChartExpenseCategoryBloc, ChartExpenseCategoryState>(
        listenWhen: (previous, current) => previous.query['bookId'] != current.query['bookId'],
        listener: (context, state) {
          BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
              prefix: 'categories',
              query: _buildQuery(state)
          ));
        },
        buildWhen: (previous, current) => previous.query['categories'] != current.query['categories'],
        builder: (context, state) {
          return MyTreeSelect(
            multiple: true,
            label: '支出分类',
            options: optionModel.options,
            value: state.query['categories'],
            onChange: (value) {
              context.read<ChartExpenseCategoryBloc>().add(ChartExpenseCategoryQueryChanged({ 'categories': value }));
            },
            loading: optionModel.status != LoadDataStatus.success,
          );
        }
    );
  }

}




