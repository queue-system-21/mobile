import 'package:flutter/material.dart';
import 'package:queue/views/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? floatingActionButton;

  const MainScaffold({super.key, this.body, this.floatingActionButton});

  Future<void> signOut(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('username');
      await prefs.remove('role');
      messenger.showSnackBar(SnackBar(content: Text('Вы успешно вышли')));
      navigator.push(
        MaterialPageRoute(builder: (context) => const SignIn())
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Не удалось выйти')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      signOut(context);
                    },
                    child: Text('Выход'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
