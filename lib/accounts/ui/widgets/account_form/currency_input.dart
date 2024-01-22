import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/index.dart';
import '/commons/index.dart';
import '/accounts/index.dart';
import '/login/index.dart';

class CurrencyInput extends StatefulWidget {

  final int action;

  const CurrencyInput({
    super.key,
    required this.action,
  });

  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(const SelectOptionsInitial(
      prefix: 'currencies',
    ));
    // 默认选择一个币种
    BlocProvider.of<AccountFormBloc>(context).add(FieldChanged({
      'currencyCode': context.read<AuthBloc>().state.initState['group']['defaultCurrencyCode']
    }));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['currencies'] ?? const SelectOptionsModel();
    return BlocSelector<AccountFormBloc, AccountFormState, String?>(
      selector: (state) => state.form['currencyCode'],
      builder: (context, state) {
        return MySelect(
          label: '币种',
          required: true,
          options: optionModel.options,
          value: state,
          onChange: (value) {
            context.read<AccountFormBloc>().add(FieldChanged({ 'currencyCode': value }));
          },
          loading: optionModel.status != LoadDataStatus.success,
          disabled: widget.action != 1,
        );
      }
    );
  }

}



