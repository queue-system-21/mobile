import 'package:flutter/material.dart';
import 'package:queue/data/models/queue.dart';
import 'package:queue/ui/view_models/provider.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/widgets/wide_button.dart';
import 'package:queue/ui/views/widgets/main_scaffold.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  final Queue _queue = Queue(nameRus: "", nameKaz: "");

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      goBackIcon: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 15,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Имя (каз)",
              ),
              onChanged: (nameKaz) {
                setState(() {
                  _queue.nameKaz = nameKaz;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Имя (рус)",
              ),
              onChanged: (nameRus) {
                setState(() {
                  _queue.nameRus = nameRus;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ответственный пользователь",
              ),
              onChanged: (username) {
                setState(() {
                  _queue.responsibleUserUsername = username;
                });
              },
            ),
            WideButton(
              text: "Сохранить",
              onPressed: () async {
                if (_queue.nameRus == "" ||
                    _queue.nameKaz == "" ||
                    _queue.responsibleUserUsername == null ||
                    _queue.responsibleUserUsername == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Заполните все поля!')),
                  );
                  return;
                }
                final nav = Navigator.of(context);
                await Provider.of<QueueViewModel>(context).add(_queue);
                nav.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
