import 'dart:convert';

import '../models/queue.dart';
import 'package:queue/data/utils/http.dart' as http;

class QueueRepo {
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
    final res = await http.post('/queue', body: jsonEncode(body));
    if (res.statusCode > 300) {
      throw Exception('Failed to create a queue');
    }
  }

  Future<void> delete(int id) async {
    final res = await http.delete('/queue/$id');
    if (res.statusCode > 300) {
      throw Exception('Failed to delete the queue');
    }
  }

}