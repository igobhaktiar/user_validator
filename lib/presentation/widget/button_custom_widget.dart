import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
  const ButtonCustomWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
  });

  final void Function() onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
