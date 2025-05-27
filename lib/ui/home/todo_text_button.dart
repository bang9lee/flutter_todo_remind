import 'package:flutter/material.dart';

class TodoTextButton extends StatelessWidget {
  const TodoTextButton({super.key, 
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5773FF),
          ),
        ),
      ),
    );
  }
}
