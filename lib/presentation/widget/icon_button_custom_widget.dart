import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class IconButtonCustomWidget extends StatelessWidget {
  const IconButtonCustomWidget({
    super.key,
    required this.onPressed,
    required this.color,
    required this.icon,
  });

  final void Function() onPressed;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
