import 'package:flutter/material.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view_models/provider.dart';

class MainScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  final bool? goBackIcon;

  const MainScaffold({
    super.key,
    this.body,
    this.floatingActionButton,
    this.goBackIcon,
  });

  Future<void> signOut(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final qvm = Provider.of<QueueViewModel>(context);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('username');
      await prefs.remove('role');
      qvm.info = null;
      messenger.showSnackBar(SnackBar(content: Text('Вы успешно вышли')));
      navigator.push(MaterialPageRoute(builder: (context) => const SignIn()));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Не удалось выйти')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: goBackIcon ?? false,
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
