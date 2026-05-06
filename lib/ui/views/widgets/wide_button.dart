import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const WideButton({super.key, this.onPressed, required this.text});

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
