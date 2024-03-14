import 'package:donpmm/src/common/fal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'outcomes_repository.g.dart';

@Riverpod(keepAlive: true)
class OutcomesRepository extends _$OutcomesRepository {
  @override
  List<FAL> build() {
    return [];
  }

  void addOutcome({required FAL fal}) {
    state = {...state, fal}.toList();
  }

  removeOutcomeByUuid(String uuid) {
    final newState = state.where((fu) => fu.uuid != uuid).toList();
    state = newState;
  }

  void clear() {
    state = [];
  }
}

@riverpod
FAL? outcomeByFalType(OutcomeByFalTypeRef ref, FALType falType) {
  final outcomes = ref.watch(outcomesRepositoryProvider);
  final outcomeFiltered = outcomes.where((f) => f.falType == falType);
  return outcomeFiltered.isEmpty ? null : outcomeFiltered.first;
}
