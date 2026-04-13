import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const AuthButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(onPressed: onPressed, child: Text(text)),
        ),
      ],
    );
  }
}
