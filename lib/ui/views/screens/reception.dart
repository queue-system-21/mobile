import 'package:flutter/material.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

import '../../view_models/provider.dart';

class Reception extends StatefulWidget {
  const Reception({super.key});

  @override
  State<Reception> createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {
  late QueueViewModel qvm;
  
  SnackBar? snackBar;

  void _onQvmChange() {
    if (qvm.queueEmpty) {
      snackBar = SnackBar(content: Text('Очередь пуста'));
    }
    if (qvm.err) {
      snackBar = SnackBar(content: Text('Ошибка'));
      qvm.err = false;
    }
    if (snackBar != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    qvm = Provider.of<QueueViewModel>(context);
    qvm.addListener(_onQvmChange);
  }

  @override
  void dispose() {
    qvm.removeListener(_onQvmChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            qvm.next();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateColor.resolveWith((_) => Colors.blue),
          ),
          child: Icon(Icons.add, color: Colors.white, size: 100),
        ),
      ),
    );
  }
}
