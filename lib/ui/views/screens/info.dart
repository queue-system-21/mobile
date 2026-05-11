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
    qvm = Provider.of<QueueViewModel>(context);
    qvm.getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: (!qvm.err && !qvm.loading)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Очередь:', style: TextStyle(fontSize: 20)),
                  Text(qvm.info.queueNameRus, style: TextStyle(fontSize: 30)),
                  Text('Номер в очереди:', style: TextStyle(fontSize: 20)),
                  Text(
                    qvm.info.number.toString(),
                    style: TextStyle(fontSize: 70),
                  ),
                ],
              ),
            )
          : Center(
              child: qvm.loading
                  ? CircularProgressIndicator()
                  : Text('Ошибка :/'),
            ),
    );
  }
}
