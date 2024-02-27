import 'package:donpmm/src/common/fal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'outcomes_repository.g.dart';

@Riverpod()
class OutcomesRepository extends _$OutcomesRepository {
  @override
  List<FAL> build() {
    return [];
  }

  void addOutcome({required FAL fal}) {
    state = [...state, fal];
  }
}

@riverpod
FAL? outcomeByFalType(OutcomeByFalTypeRef ref, FALType falType) {
  final outcomes = ref.watch(outcomesRepositoryProvider);
  final outcomeFiltered = outcomes.where((f) => f.falType == falType);
  return outcomeFiltered.isEmpty ? null : outcomeFiltered.first;
}
