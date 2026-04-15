import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:queue/components/auth_wrapper.dart';
import 'package:queue/components/error_dialog.dart';
import 'package:queue/utils/backend_uri.dart';
import 'package:queue/views/sign_in.dart';
import 'package:http/http.dart' as http;

import '../components/auth_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _username = '';
  String _password = '';

  Future<void> signUp() async {
    try {
      final uri = '/auth/sign-up';
      final body = {'username': _username, 'password': _password};
      final res = await http.post(backendUri(uri), body: jsonEncode(body));
      if (res.statusCode > 300) {
        throw Exception('Sign up failed (${res.statusCode}): ${res.body}');
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Вы успешно зарегистрировались!'),
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => ErrorDialog(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      children: [
        Text('Регистрация'),
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
          onPressed: signUp,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ),
            );
          },
          child: Text('Войти'),
        ),
      ],
    );
  }
}
