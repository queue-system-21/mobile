import 'package:flutter/material.dart';
import 'package:queue/components/auth_wrapper.dart';
import 'package:queue/sign_in.dart';

import 'components/auth_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Имя пользователя',
          ),
          onChanged: (username) {
            _username = username;
          },
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Пароль',
          ),
          onChanged: (password) {
            _password = password;
          },
        ),
        AuthButton(
          text: 'Зарегистрироваться',
          onPressed: () {
            print("username: $_username");
            print("password: $_password");
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SignIn())
            );
          },
          child: Text('Войти'),
        ),
      ],
    );
  }
}
