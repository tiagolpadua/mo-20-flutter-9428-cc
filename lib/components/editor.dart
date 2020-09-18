import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool autofocus;
  final bool hasError;
  final void Function(String) onChanged;

  Editor({
    @required this.controller,
    @required this.label,
    @required this.hint,
    this.icon,
    this.onChanged,
    this.autofocus = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        // 7 - Bind the onChanged property to the onChanged TextField property
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: icon != null ? Icon(this.icon) : null,
          labelText: label,
          hintText: hint,
          // 8 - Use the hasError to show some different border
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: hasError ? Colors.red : Colors.teal),
          ),
        ),
        keyboardType: TextInputType.number,
        autofocus: autofocus,
      ),
    );
  }
}