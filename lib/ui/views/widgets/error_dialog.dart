import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  final String? message;

  const ErrorDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ошибка'),
      content: Text(message ?? 'Попробуйте еще раз'),
    );
  }
}