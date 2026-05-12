import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:queue/ui/views/widgets/auth_wrapper.dart';
import 'package:queue/ui/views/widgets/error_dialog.dart';
import 'package:queue/ui/views/screens/sign_in.dart';
import 'package:queue/data/utils/http.dart' as http;

import '../../../l10n/app_localizations.dart';
import '../widgets/wide_button.dart';

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
      final res = await http.post(uri, body: jsonEncode(body));
      if (res.statusCode > 300) {
        throw Exception('Sign up failed (${res.statusCode}): ${res.body}');
      }
      if (mounted) {
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
      if (mounted) {
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
        Text(AppLocalizations.of(context)!.signingUp),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: AppLocalizations.of(context)!.username,
          ),
          onChanged: (username) {
            _username = username;
          },
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: AppLocalizations.of(context)!.password,
          ),
          onChanged: (password) {
            _password = password;
          },
        ),
        WideButton(
          text: AppLocalizations.of(context)!.toSignUp,
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
          child: Text(AppLocalizations.of(context)!.toSignIn),
        ),
      ],
    );
  }
}
