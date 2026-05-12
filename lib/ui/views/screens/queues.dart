import 'package:flutter/material.dart';
import 'package:queue/l10n/app_localizations.dart';
import 'package:queue/ui/view_models/provider.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/screens/info.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

import '../widgets/localize_text.dart';

class Queues extends StatefulWidget {
  const Queues({super.key});

  @override
  State<StatefulWidget> createState() => _QueuesState();
}

class _QueuesState extends State<Queues> {
  late QueueViewModel qvm;

  bool triedToFetchAll = false;

  void _onQvmChange() {
    if (qvm.err) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.error)));
      qvm.err = false;
    }
    if (qvm.joined) {
      qvm.joined = false;
      qvm.loading = true;
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const Info()));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    qvm = Provider.of<QueueViewModel>(context);
    qvm.addListener(_onQvmChange);
    if (!triedToFetchAll) {
      qvm.fetchAll();
      setState(() {
        triedToFetchAll = true;
      });
    }
  }

  @override
  void dispose() {
    qvm.removeListener(_onQvmChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: !qvm.loading
          ? ListView.separated(
              itemBuilder: (context, index) => ListTile(
                title: LocalizeText(qvm.queues[index]),
                trailing: IconButton(
                  onPressed: () {
                    qvm.join(index);
                  },
                  icon: Icon(Icons.add),
                ),
              ),
              separatorBuilder: (context, _) => const Divider(),
              itemCount: qvm.queues.length,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
