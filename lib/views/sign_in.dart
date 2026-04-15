import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:queue/components/auth_button.dart';
import 'package:queue/components/auth_wrapper.dart';
import 'package:queue/components/error_dialog.dart';
import 'package:queue/utils/backend_uri.dart';
import 'package:queue/views/queues.dart';
import 'package:queue/views/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _username = '';
  String _password = '';

  Future<void> signIn() async {
    try {
      var uri = '/auth/sign-in';
      var body = {
        "username": _username,
        "password": _password,
      };
      var res = await http.post(
        backendUri(uri),
        body: jsonEncode(body),
      );
      if (res.statusCode > 300) {
        throw Exception('Sign in failed (${res.statusCode}): ${res.body}');
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Вы успешно авторизовались')),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Queues(),
          )
        );
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => const ErrorDialog(),
        );
      }
    }
  }

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
          onPressed: signIn,
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
