import 'package:flutter/material.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

class Reception extends StatelessWidget {
  const Reception({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: Text('reception'),
      ),
    );
  }
}