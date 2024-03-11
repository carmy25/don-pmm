import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/features/outcome/data/outcomes_repository.dart';
import 'package:donpmm/src/features/outcome/presentation/outcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class OutcomeScreen extends ConsumerStatefulWidget {
  const OutcomeScreen({
    super.key,
  });

  @override
  OutcomeScreenState createState() => OutcomeScreenState();
}

class OutcomeScreenState extends ConsumerState {
  final List<Map<String, dynamic>> _outcomeData = [];
  final _formKey = GlobalKey<FormState>();

  OutcomeScreenState();

  _saveOutcomes() {
    final outcomesRepo = ref.watch(outcomesRepositoryProvider.notifier);

    for (final o in _outcomeData.where((e) => e['availableLtrs'] != null)) {
      outcomesRepo.addOutcome(
          fal: FAL(
              falType:
                  FALType.values.firstWhere((e) => e.name == o['comodity']),
              uuid: o['uuid'] ?? const Uuid().v4(),
              amountLtrs: o['availableLtrs']));
    }
  }

  @override
  Widget build(BuildContext context) {
    final outcomes = ref.watch(outcomesRepositoryProvider);
    for (final outcome in outcomes) {
      _outcomeData.add({
        'uuid': outcome.uuid,
        'comodity': outcome.falType.name,
        'availableLtrs': outcome.amountLtrs,
      });
    }
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
                    child: SingleChildScrollView(
                        child: OutcomeWidget(data: _outcomeData)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveOutcomes();
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
