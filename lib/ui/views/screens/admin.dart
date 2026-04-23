import 'package:flutter/material.dart';
import 'package:queue/ui/view_models/provider.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

import '../../view_models/queue.view_model.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final qvm = Provider.of<QueueViewModel>(context);
    qvm.fetchAll();
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
