import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {

  final List<Widget> children;

  const AuthWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: children,
        ),
      ),
    );
  }
}