import 'package:flutter/material.dart';
import 'package:queue/ui/view_models/auth.view_model.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/screens/info.dart';
import 'package:queue/ui/views/widgets/wide_button.dart';
import 'package:queue/ui/views/widgets/auth_wrapper.dart';
import 'package:queue/ui/views/widgets/error_dialog.dart';
import 'package:queue/ui/views/screens/admin.dart';
import 'package:queue/ui/views/screens/queues.dart';
import 'package:queue/ui/views/screens/reception.dart';
import 'package:queue/ui/views/screens/sign_up.dart';

import '../../view_models/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late AuthViewModel avm;
  late QueueViewModel qvm;

  String _username = '';
  String _password = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    avm = Provider.of<AuthViewModel>(context);
    qvm = Provider.of<QueueViewModel>(context);
  }

  Future<void> signIn() async {
    try {
      final messenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);
      final claims = await avm.signIn(_username, _password);
      await qvm.getInfo();

      messenger.showSnackBar(
        SnackBar(content: Text('Вы успешно авторизовались')),
      );
      navigator.push(
        MaterialPageRoute(
          builder: (context) {
            return switch (claims['role'].toString()) {
              'user' => qvm.joined ? Info() : Queues(),
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
            setState(() {
              _username = username;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Пароль',
          ),
          onChanged: (password) {
            setState(() {
              _password = password;
            });
          },
        ),
        WideButton(text: 'Войти', onPressed: signIn),
        TextButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const SignUp()));
          },
          child: Text('Зарегистрироваться'),
        ),
      ],
    );
  }
}
