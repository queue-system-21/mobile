import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue/l10n/app_localizations.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/screens/info.dart';
import 'package:queue/ui/views/widgets/wide_button.dart';
import 'package:queue/ui/views/widgets/auth_wrapper.dart';
import 'package:queue/ui/views/widgets/error_dialog.dart';
import 'package:queue/ui/views/screens/admin.dart';
import 'package:queue/ui/views/screens/queues.dart';
import 'package:queue/ui/views/screens/reception.dart';
import 'package:queue/ui/views/screens/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/utils/http.dart' as http;
import '../../view_models/provider.dart';

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
      final uri = '/auth/sign-in';
      final body = {"username": _username, "password": _password};
      final qvm = Provider.of<QueueViewModel>(context);
      final messenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);
      final localization = AppLocalizations.of(context);
      final res = await http.post(uri, body: jsonEncode(body));
      if (res.statusCode > 300) {
        throw Exception('Sign in failed (${res.statusCode}): ${res.body}');
      }

      final prefs = await SharedPreferences.getInstance();
      http.token = jsonDecode(res.body)['token'];
      prefs.setString('token', http.token!);
      final claims = JwtDecoder.decode(http.token!);
      prefs.setString('username', claims['username']);
      prefs.setString('role', claims['role']);

      messenger.showSnackBar(
        SnackBar(content: Text(localization!.successfulSignIn)),
      );

      await qvm.getInfo();

      navigator.push(
        MaterialPageRoute(
          builder: (context) {
            return switch (claims['role'].toString()) {
              'user' => qvm.info != null ? Info() : Queues(),
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
        Text(AppLocalizations.of(context)!.signingIn),
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
          text: AppLocalizations.of(context)!.toSignIn,
          onPressed: signIn,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const SignUp()));
          },
          child: Text(AppLocalizations.of(context)!.toSignUp),
        ),
      ],
    );
  }
}
