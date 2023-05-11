import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'index.dart';
import '/login/index.dart';

class LoginForm extends StatelessWidget {

  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          // Message.success('登录成功');
        }
      },
      child: Column(
        children: const [
          UsernameInput(),
          SizedBox(height: 10),
          PasswordInput(),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: SubmitBtn(),
          ),
          if (!kIsWeb) SizedBox(height: 30),
          if (!kIsWeb) SizedBox(
            width: double.infinity,
            height: 50,
            child: WeChatBtn(),
          ),
        ],
      )
    );
  }
}