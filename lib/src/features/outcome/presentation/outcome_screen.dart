import 'package:collection/collection.dart';
import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
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

  Future<FALType> _createNewFalType(Map<String, dynamic> data) async {
    final falTypesRepo = ref.read(falTypesRepositoryProvider.notifier);
    final falType = FALType(
        uuid: const Uuid().v4(),
        name: data['comodity'],
        category:
            FALCategory.values.firstWhere((e) => e.name == data['category']),
        density: data['density']);
    await falTypesRepo.addFalType(falType);
    return falType;
  }

  Future<void> _saveOutcomes() async {
    final outcomesRepo = ref.watch(outcomesRepositoryProvider.notifier);
    final falTypes = await ref.watch(falTypesRepositoryProvider.future);

    for (final o in _outcomeData) {
      final falType =
          falTypes.firstWhereOrNull((e) => e.name == o['comodity']) ??
              (await _createNewFalType(o));
      outcomesRepo.addOutcome(
          fal: FAL(
              falType: falType,
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
        'density': outcome.falType.density,
        'category': outcome.falType.category.name
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
                              _saveOutcomes()
                                  .then((value) => Navigator.pop(context));
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
