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
