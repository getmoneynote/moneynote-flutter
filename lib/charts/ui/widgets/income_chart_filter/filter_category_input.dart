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

  Map<String, dynamic> _buildQuery(ChartIncomeCategoryState state) {
    Map<String, dynamic> query = {
      'bookId': state.query['bookId'],
      'type': 'INCOME',
    };
    return query;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
        prefix: 'categories',
        query: _buildQuery(context.read<ChartIncomeCategoryBloc>().state)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['categories'] ?? const SelectOptionsModel();
    return BlocConsumer<ChartIncomeCategoryBloc, ChartIncomeCategoryState>(
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
            label: '收入分类',
            options: optionModel.options,
            value: state.query['categories'],
            onChange: (value) {
              context.read<ChartIncomeCategoryBloc>().add(ChartIncomeCategoryQueryChanged({ 'categories': value }));
            },
            loading: optionModel.status != LoadDataStatus.success,
          );
        }
    );
  }

}




