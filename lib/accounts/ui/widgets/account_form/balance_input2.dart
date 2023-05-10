import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class BalanceInput extends StatefulWidget {

  final int action;

  const BalanceInput({
    super.key,
    required this.action,
  });

  @override
  State<BalanceInput> createState() => _BalanceInputState();

}

class _BalanceInputState extends State<BalanceInput> {

  late TextEditingController controller;
  late String? errorText;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final balance = context.watch<AccountFormBloc>().state.balanceFormz;
    controller.value = controller.value.copyWith(text: balance.value);
    errorText = balance.isValid ? null : '请输入账户名称' ;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyFormText(
      label: '余额',
      required: true,
      errorText: errorText, value: '', onChange: (String value) {  } ,
    );
  }

}

