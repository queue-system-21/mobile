import 'package:flutter/material.dart';
import 'package:queue/components/main_scaffold.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: Text('admin'),
      ),
    );
  }
}