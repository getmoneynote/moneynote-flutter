import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/login/index.dart';

class ApiUrlInput extends StatelessWidget {

  const ApiUrlInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, NotEmptyFormz>(
      selector: (state) => state.apiUrlFormz,
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context.read<LoginBloc>().add(ApiUrlChanged(value)),
          decoration: InputDecoration(
            hintText: '后台地址',
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            errorText: (state.isPure || state.isValid) ? null : '请输入后端接口地址' ,
          ),
        );
      },
    );
  }
}