import 'package:flutter/material.dart';
import 'package:queue/l10n/app_localizations.dart';
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

  bool triedToGetInfo = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    qvm = Provider.of<QueueViewModel>(context);
    if (qvm.info == null && !triedToGetInfo) {
      qvm.getInfo();
      setState(() {
        triedToGetInfo = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      actions: [
        IconButton(
          onPressed: () {
            qvm.getInfo();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.updated)),
            );
          },
          icon: Icon(Icons.update),
        ),
      ],
      body: (!qvm.err && !qvm.loading && qvm.info != null)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.queue,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(qvm.info!.queueNameRus, style: TextStyle(fontSize: 30)),
                  Text(
                    AppLocalizations.of(context)!.queueNumber,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    qvm.info!.number.toString(),
                    style: TextStyle(fontSize: 70),
                  ),
                ],
              ),
            )
          : Center(
              child: qvm.loading
                  ? CircularProgressIndicator()
                  : Text('${AppLocalizations.of(context)!.error} :/'),
            ),
    );
  }
}
