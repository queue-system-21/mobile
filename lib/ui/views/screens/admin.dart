import 'package:flutter/material.dart';
import 'package:queue/ui/view_models/provider.dart';
import 'package:queue/ui/views/widgets/create_dialog.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

import '../../view_models/queue.view_model.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  void _onViewModelChange() {
    final qvm = Provider.of<QueueViewModel>(context);
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
    final qvm = Provider.of<QueueViewModel>(context);
    qvm.addListener(_onViewModelChange);
    qvm.fetchAll();
  }

  @override
  void dispose() {
    Provider.of<QueueViewModel>(context).removeListener(_onViewModelChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queueVm = Provider.of<QueueViewModel>(context);
    return MainScaffold(
      body: ListView.separated(
        itemBuilder: (context, index) =>
            ListTile(title: Text(queueVm.queues[index].nameRus)),
        separatorBuilder: (context, _) => const Divider(),
        itemCount: queueVm.queues.length,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const CreateDialog()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
