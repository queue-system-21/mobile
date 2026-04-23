import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:queue/components/main_scaffold.dart';
import 'package:queue/data/queue.dart';
import 'package:queue/utils/http.dart' as http;

class Admin extends StatefulWidget {
  final AdminViewModel vm;

  const Admin({super.key, required this.vm});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  @override
  void initState() {
    super.initState();
    widget.vm.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: ListenableBuilder(
        listenable: widget.vm,
        builder: (context, _) => ListView.separated(
          itemBuilder: (context, index) =>
              ListTile(title: Text(widget.vm.queues[index].nameRus)),
          separatorBuilder: (context, _) => const Divider(),
          itemCount: widget.vm.queues.length,
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class AdminViewModel extends ChangeNotifier {
  final AdminRepo repo;

  List<Queue> queues = [];
  bool err = false;

  AdminViewModel({required this.repo});

  Future<void> fetchAll() async {
    try {
      queues = await repo.fetchAll();
    } catch (e) {
      err = true;
    } finally {
      notifyListeners();
    }
  }

  Future<void> add(Queue queue) async {
    queues.add(queue);
    notifyListeners();
    try {
      await repo.add(queue);
    } catch (e) {
      err = true;
      queues.removeLast();
    } finally {
      notifyListeners();
    }
  }
}

class AdminRepo {
  Future<List<Queue>> fetchAll() async {
    final res = await http.get('/queue');
    if (res.statusCode > 300) {
      throw Exception('Failed to fetch all queues');
    }
    final jsons = jsonDecode(res.body) as List;
    return jsons.map((json) => Queue.fromJson(json)).toList();
  }

  Future<void> add(Queue queue) async {
    final body = {
      'nameRus': queue.nameRus,
      'nameKaz': queue.nameKaz,
      'responsibleUserUsername': queue.responsibleUserUsername!,
    };
    await http.post('/queue', body: jsonEncode(body));
  }
}
