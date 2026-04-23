import 'package:flutter/material.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

class Queues extends StatelessWidget {
  const Queues({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      body: Center(
        child: Text('queues'),
      ),
    );
  }
}
