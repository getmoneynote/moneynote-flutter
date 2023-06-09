import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/flows/index.dart';

class AccountInput extends StatefulWidget {

  final int action;

  const AccountInput({
    super.key,
    required this.action,
  });

  @override
  State<AccountInput> createState() => _AccountInputState();
}

class _AccountInputState extends State<AccountInput> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(const SelectOptionsInitial(
      prefix: 'accounts',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['accounts'] ?? const SelectOptionsModel();
    return BlocBuilder<FlowFormBloc, FlowFormState>(
      buildWhen: (previous, current) => previous.form['accountId'] != current.form['accountId'] || previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        var options = [ ...optionModel.options ];
        if (state.tabIndex == 0) {
          options = options.where((e) => e['canExpense']).toList();
        }
        if (state.tabIndex == 1) {
          options = options.where((e) => e['canIncome']).toList();
        }
        if (state.tabIndex == 2) {
          options = options.where((e) => e['canTransferFrom']).toList();
        }
        if (widget.action != 1) {
          if (state.currentRow['account'] != null && !options.map((e) => e['id']).contains(state.currentRow['account']['id'])) {
            options.insert(0, state.currentRow['account']);
          }
        }
        return MySelect(
          label: state.tabIndex == 2 ? '转出账户' : '账户',
          required: state.tabIndex == 2 ? true : false,
          allowClear: true,
          options: options,
          value: state.form['accountId'],
          onChange: (value) {
            context.read<FlowFormBloc>().add(AccountChanged( options.firstWhere((e) => e['id'] == value) ));
          },
          onClear: () {
            context.read<FlowFormBloc>().add(const AccountChanged(null));
          },
          loading: optionModel.status != LoadDataStatus.success,
        );
      }
    );
  }

}



