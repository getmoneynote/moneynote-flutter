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

  Map<String, dynamic> _buildQuery(ChartIncomeCategoryState state) {
    Map<String, dynamic> query = {
      'bookId': state.query['bookId'],
      'canIncome': true,
    };
    return query;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
      prefix: 'payees',
      query: _buildQuery(context.read<ChartIncomeCategoryBloc>().state)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['payees'] ?? const SelectOptionsModel();
    return BlocConsumer<ChartIncomeCategoryBloc, ChartIncomeCategoryState>(
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
            context.read<ChartIncomeCategoryBloc>().add(ChartIncomeCategoryQueryChanged({ 'payees': value }));
          },
          loading: optionModel.status != LoadDataStatus.success,
        );
      }
    );
  }

}




