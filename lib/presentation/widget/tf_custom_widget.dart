import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class TfCustomWidget extends StatelessWidget {
  const TfCustomWidget({
    super.key,
    required TextEditingController usernameController,
    required this.onChanged,
  }) : _usernameController = usernameController;

  final TextEditingController _usernameController;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Enter your username',
        filled: true,
        fillColor: ColorsAsset.lightCyan,
        label: Text('Username'),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      onChanged: onChanged,
      controller: _usernameController,
    );
  }
}
