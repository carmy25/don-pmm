import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/outcome.dart';

part 'outcomes_repository.g.dart';

@Riverpod()
class OutcomesRepository extends _$OutcomesRepository {
  @override
  FutureOr<List<Outcome>> build() {
    debugPrint('OutcomesRepos init');
    return [];
  }

  Future<void> addOutcome(
      {required String uuid,
      required String name,
      required double amount}) async {
    final previousState = await future;
    state = AsyncData(
        [...previousState, Outcome(uuid: uuid, name: name, amount: amount)]);
  }
}
