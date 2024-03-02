import 'package:donpmm/src/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputFormField extends ConsumerWidget {
  const InputFormField(
      {super.key,
      this.controller,
      this.icon,
      this.text,
      this.isNumeric = false});

  final TextEditingController? controller;
  final Widget? icon;
  final String? text;
  final bool isNumeric;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: isNumeric ? validateNotEmptyNumber : validateNotEmpty,
      controller: controller,
      inputFormatters: isNumeric
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
            ]
          : null, // Only numbers can be entered
      decoration: InputDecoration(
        icon: icon, //icon of text field
        labelText: text, //label text of field
      ),
    );
  }
}
