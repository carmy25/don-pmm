import 'package:donpmm/src/features/outcome/presentation/outcome_widget_sf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutcomeScreen extends ConsumerStatefulWidget {
  const OutcomeScreen({
    super.key,
  });

  @override
  OutcomeScreenState createState() => OutcomeScreenState();
}

class OutcomeScreenState extends ConsumerState {
  final _formKey = GlobalKey<FormState>();

  OutcomeScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ПММ передано в інші в/ч'),
        ),
        body: Container(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(child: OutcomeWidgetSf()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Зберегти'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
