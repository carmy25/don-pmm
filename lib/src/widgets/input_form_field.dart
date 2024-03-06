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
      this.allowEmpty = false,
      this.isNumeric = false});

  final TextEditingController? controller;
  final Widget? icon;
  final String? text;
  final bool isNumeric;
  final bool allowEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? Function(String?)? validator;
    if (isNumeric && !allowEmpty) {
      validator = validateNotEmptyNumber;
    } else if (!allowEmpty) {
      validator = validateNotEmpty;
    }
    if (isNumeric && allowEmpty) {
      validator = validateNotEmpty;
    }
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: validator,
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
