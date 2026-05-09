import 'package:flutter/foundation.dart';
import 'package:queue/data/models/info.dart';

import '../../data/models/queue.dart';
import '../../data/repos/queue.repo.dart';

class QueueViewModel extends ChangeNotifier {
  final QueueRepo repo;

  List<Queue> queues = [];
  bool err = false;
  bool loading = false;
  bool joined = false;
  late Info info;

  QueueViewModel({required this.repo});

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

  Future<void> delete(int id) async {
    final q = queues.removeLast();
    notifyListeners();
    try {
      await repo.delete(id);
    } catch (e) {
      err = true;
      queues.add(q);
    } finally {
      notifyListeners();
    }
  }

  Future<void> join(int index) async {
    loading = true;
    notifyListeners();
    try {
      await repo.join(queues[index].id!);
      joined = true;
    } catch (e) {
      err = true;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getInfo() async {
    try {
      info = await repo.getInfo();
    } catch (e) {
      err = true;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

}
