import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:queue/components/main_scaffold.dart';
import 'package:queue/data/queue.dart';
import 'package:queue/utils/http.dart' as http;
import 'package:queue/utils/backend_uri.dart';

class Admin extends StatefulWidget {
  final AdminViewModel vm;

  const Admin({super.key, required this.vm});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold();
  }
}

class AdminViewModel extends ChangeNotifier {
  final AdminRepo repo;

  AdminViewModel({required this.repo});
}

class AdminRepo {
  Future<List<Queue>> fetchAll() async {
    final res = await http.get('/queue');
    final List<Map<String, dynamic>> jsons = jsonDecode(res.body);
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
