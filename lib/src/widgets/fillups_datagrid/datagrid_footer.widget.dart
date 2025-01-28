import 'package:flutter/material.dart';

class DataGridFooterWidget extends StatelessWidget {
  final void Function()? onPressed;
  const DataGridFooterWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text('Додати нову заправку'),
    );
  }
}
