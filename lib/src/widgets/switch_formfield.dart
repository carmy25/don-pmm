import 'package:flutter/material.dart';

class SwitchFormField extends StatefulWidget {
  final String title;
  final String subtitle;
  final SwitchController controller;

  const SwitchFormField(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.controller});

  @override
  State<StatefulWidget> createState() => _SwitchFormFieldState();
}

class _SwitchFormFieldState extends State<SwitchFormField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SwitchListTile(
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        secondary: widget.controller.isSwitchOn
            ? Icon(
                Icons.warning,
                color: Colors.redAccent,
              )
            : Icon(Icons.info, color: Colors.lightBlue),
        value: widget.controller.isSwitchOn,
        onChanged: (bool newValue) {
          setState(() {
            widget.controller.setValue(newValue);
          });
        },
      ),
    );
  }
}

class SwitchController extends ChangeNotifier {
  bool isSwitchOn;
  SwitchController({this.isSwitchOn = false});

  void setValue(bool value) {
    isSwitchOn = value;
  }
}
