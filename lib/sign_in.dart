import 'package:flutter/material.dart';

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
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print("username: $_username");
                      print("password: $_password");
                    },
                    child: Text('Войти'),
                  ),
                ),
              ],
            ),
            TextButton(onPressed: () {}, child: Text('Зарегистрироваться'))
          ],
        ),
      ),
    );
  }
}
