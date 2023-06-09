import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/flows/index.dart';

class PayeeInput extends StatefulWidget {

  const PayeeInput({
    super.key,
    required this.action,
  });

  final int action;

  @override
  State<PayeeInput> createState() => _PayeeInputState();
}

class _PayeeInputState extends State<PayeeInput> {

  Map<String, dynamic> _buildQuery(FlowFormState state) {
    Map<String, dynamic> query = {
      'bookId': state.currentBook['id'],
      if (widget.action != 1) 'keep': state.currentRow['payee']?['id']
    };
    if (state.tabIndex == 0) {
      query = { ...query, 'canExpense': true };
    }
    if (state.tabIndex == 1) {
      query = { ...query, 'canIncome': true };
    }
    return query;
  }

  @override
  void initState() {
    super.initState();
    var state = context.read<FlowFormBloc>().state;
    BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
      prefix: 'payees',
      query: _buildQuery(state)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['payees'] ?? const SelectOptionsModel();
    return BlocConsumer<FlowFormBloc, FlowFormState>(
      listenWhen: (previous, current) => previous.currentBook != current.currentBook || previous.tabIndex != current.tabIndex,
      listener: (context, state) {
        BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
          prefix: 'payees',
          query: _buildQuery(state)
        ));
      },
      buildWhen: (previous, current) => previous.form['payeeId'] != current.form['payeeId'] || previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        return MySelect(
          key: UniqueKey(),
          label: '交易对象',
          required: false,
          allowClear: true,
          options: optionModel.options,
          value: state.form['payeeId'],
          onChange: (value) {
            context.read<FlowFormBloc>().add(FieldChanged({ 'payeeId': value }));
          },
          onClear: () {
            context.read<FlowFormBloc>().add(const FieldChanged({ 'payeeId': '' }));
          },
          loading: optionModel.status != LoadDataStatus.success,
        );
      },
    );
  }

}



