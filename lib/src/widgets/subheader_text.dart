import 'package:flutter/material.dart';

class SubheaderText extends StatelessWidget {
  const SubheaderText(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        child: Text(data,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)));
  }
}
