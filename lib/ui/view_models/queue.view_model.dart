import 'package:flutter/foundation.dart';

import '../../data/models/queue.dart';
import '../../data/repos/queue.repo.dart';

class QueueViewModel extends ChangeNotifier {
  final QueueRepo repo;

  List<Queue> queues = [];
  bool err = false;
  bool loading = false;

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
    try {
      await repo.join(queues[index].id!);
    } catch (e) {
      err = true;
    } finally {
      notifyListeners();
    }
  }
}
