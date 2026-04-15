import 'package:flutter/material.dart';
import 'package:queue/components/auth_button.dart';
import 'package:queue/components/auth_wrapper.dart';
import 'package:queue/views/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      children: [
        Text('Вход'),
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
          text: 'Войти',
          onPressed: () {
            print("username: $_username");
            print("password: $_password");
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignUp())
            );
          },
          child: Text('Зарегистрироваться'),
        ),
      ],
    );
  }
}
