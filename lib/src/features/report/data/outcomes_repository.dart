import 'package:donpmm/src/common/fal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'outcomes_repository.g.dart';

@Riverpod()
class OutcomesRepository extends _$OutcomesRepository {
  @override
  FutureOr<List<FAL>> build() {
    debugPrint('OutcomesRepos init');
    return [];
  }

  Future<void> addOutcome({required FAL fal}) async {
    final previousState = await future;
    state = AsyncData([...previousState, fal]);
  }
}

@riverpod
FAL? outcomeByFalType(OutcomeByFalTypeRef ref, FALType falType) {
  final outcomes = ref.watch(outcomesRepositoryProvider).value!;
  final outcomeFiltered = outcomes.where((f) => f.falType == falType);
  return outcomeFiltered.isEmpty ? null : outcomeFiltered.first;
}
