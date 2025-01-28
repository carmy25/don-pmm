import 'package:flutter/material.dart';

class DataGridFooterWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  const DataGridFooterWidget({super.key, required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text ?? 'Додати новe паливо'),
    );
  }
}
