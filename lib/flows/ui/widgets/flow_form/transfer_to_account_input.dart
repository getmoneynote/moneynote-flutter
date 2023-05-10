import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/index.dart';
import '/commons/index.dart';
import '/flows/index.dart';

class TransferToAccountInput extends StatefulWidget {

  final int action;

  const TransferToAccountInput({
    super.key,
    required this.action,
  });

  @override
  State<TransferToAccountInput> createState() => _TransferToAccountInputState();
}

class _TransferToAccountInputState extends State<TransferToAccountInput> {

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
      buildWhen: (previous, current) => previous.form['toId'] != current.form['toId'] || previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        var options = [ ...optionModel.options ];
        options = options.where((e) => e['canTransferTo']).toList();
        if (widget.action != 1) {
          if (state.currentRow['to'] != null && !options.map((e) => e['id']).contains(state.currentRow['to']['id'])) {
            options.insert(0, state.currentRow['to']);
          }
        }
        return MySelect(
          key: UniqueKey(),
          label: '转入账户',
          required: true,
          options: options,
          value: state.form['toId'],
          onChange: (value) {
            context.read<FlowFormBloc>().add(FieldChanged({ 'toId': value }));
          },
          loading: optionModel.status != LoadDataStatus.success,
        );
      }
    );
  }

}



