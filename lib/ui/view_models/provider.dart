import 'package:flutter/widgets.dart';

class Provider<T extends Listenable> extends InheritedNotifier<T> {
  const Provider({super.key, required super.notifier, required super.child});

  static T of<T extends Listenable>(BuildContext context) {
    Provider<T>? provider = context
        .dependOnInheritedWidgetOfExactType<Provider<T>>();

    if (provider == null) {
      throw Exception('No provider was found in the context');
    }

    final T? notifier = provider.notifier;

    if (notifier == null) {
      throw Exception('No notifier was found in the provider');
    }

    return notifier;
  }

  factory Provider.multiple({
    required List<T> notifiers,
    required StatelessWidget root,
  }) {
    final notifier = notifiers.removeLast();
    if (notifiers.isEmpty) {
      return Provider(notifier: notifier, child: root);
    }
    return Provider(
      notifier: notifier,
      child: Provider.multiple(notifiers: notifiers, root: root),
    );
  }
}
