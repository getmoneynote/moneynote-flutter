import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/charts/index.dart';

class FilterPayeeInput extends StatefulWidget {

  const FilterPayeeInput({
    super.key,
  });

  @override
  State<FilterPayeeInput> createState() => _FilterPayeeInputState();
}

class _FilterPayeeInputState extends State<FilterPayeeInput> {

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
      prefix: 'payees',
      query: _buildQuery(context.read<ChartExpenseCategoryBloc>().state)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['payees'] ?? const SelectOptionsModel();
    return BlocConsumer<ChartExpenseCategoryBloc, ChartExpenseCategoryState>(
      listenWhen: (previous, current) => previous.query['bookId'] != current.query['bookId'],
      listener: (context, state) {
        BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
            prefix: 'payees',
            query: _buildQuery(state)
        ));
      },
      buildWhen: (previous, current) => previous.query['payees'] != current.query['payees'],
      builder: (context, state) {
        return MySelect(
          multiple: true,
          label: '交易对象',
          options: optionModel.options,
          value: state.query['payees'],
          onChange: (value) {
            context.read<ChartExpenseCategoryBloc>().add(ChartExpenseCategoryQueryChanged({ 'payees': value }));
          },
          loading: optionModel.status != LoadDataStatus.success,
        );
      }
    );
  }

}




