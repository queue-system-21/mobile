import 'package:flutter/material.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

import '../../view_models/provider.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<StatefulWidget> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  late QueueViewModel qvm;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    qvm = Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(body: Center(child: Text('info')));
  }
}
