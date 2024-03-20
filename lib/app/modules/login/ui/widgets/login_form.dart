import 'package:flutter/material.dart';
import 'user_name_input.dart';
import 'password_name_input.dart';
import 'api_url_input.dart';
import 'submit_btn.dart';

class LoginForm extends StatelessWidget {

  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UsernameInput(),
        SizedBox(height: 10),
        PasswordInput(),
        SizedBox(height: 10),
        ApiUrlInput(),
        SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: SubmitBtn(),
        ),
      ],
    );
  }

}