import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue/components/auth_button.dart';
import 'package:queue/components/auth_wrapper.dart';
import 'package:queue/components/error_dialog.dart';
import 'package:queue/utils/backend_uri.dart';
import 'package:queue/views/admin.dart';
import 'package:queue/views/queues.dart';
import 'package:queue/views/reception.dart';
import 'package:queue/views/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      var body = {"username": _username, "password": _password};
      final messenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);
      var res = await http.post(backendUri(uri), body: jsonEncode(body));
      if (res.statusCode > 300) {
        throw Exception('Sign in failed (${res.statusCode}): ${res.body}');
      }

      final prefs = await SharedPreferences.getInstance();
      final token = jsonDecode(res.body)['token'];
      prefs.setString('token', token);
      final claims = JwtDecoder.decode(token);
      prefs.setString('username', claims['username']);
      prefs.setString('role', claims['role']);

      messenger.showSnackBar(
        SnackBar(content: Text('Вы успешно авторизовались')),
      );
      navigator.push(
        MaterialPageRoute(
          builder: (context) {
            return switch (claims['role'].toString()) {
              'user' => Queues(),
              'receptionist' => Reception(),
              'admin' => Admin(),
              _ => throw UnimplementedError(),
            };
          },
        ),
      );
    } catch (e) {
      if (mounted) {
        showDialog(context: context, builder: (_) => const ErrorDialog());
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
        AuthButton(text: 'Войти', onPressed: signIn),
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
