import 'package:flutter/material.dart';
import 'package:queue/ui/view_models/provider.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

class Queues extends StatefulWidget {
  const Queues({super.key});

  @override
  State<StatefulWidget> createState() => _QueuesState();
}

class _QueuesState extends State<Queues> {
  late QueueViewModel qvm;

  void _onQvmChange() {
    if (qvm.err) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка')));
      qvm.err = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    qvm = Provider.of<QueueViewModel>(context);
    qvm.addListener(_onQvmChange);
    qvm.fetchAll();
  }

  @override
  void dispose() {
    qvm.removeListener(_onQvmChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Text(qvm.queues[index].nameRus),
          trailing: IconButton(
            onPressed: () {
              qvm.join(index);
            },
            icon: Icon(Icons.add),
          ),
        ),
        separatorBuilder: (context, _) => const Divider(),
        itemCount: qvm.queues.length,
      ),
    );
  }
}
