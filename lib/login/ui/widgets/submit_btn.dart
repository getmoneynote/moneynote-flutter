import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/login/index.dart';

class SubmitBtn extends StatelessWidget {

  const SubmitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.valid != current.valid || previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.valid && !state.submissionStatus.isInProgress ?
              () {context.read<LoginBloc>().add(const LoginButtonPressed());} : null,
          child: state.submissionStatus.isInProgress ?
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 1.5,
            ) : const Text('登录')
        );
      },
    );
  }
}