import 'package:donpmm/src/common/fal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/waybill.dart';
import '../domain/fillup.dart';

part 'fillups_repository.g.dart';

@Riverpod(keepAlive: true)
class FillupList extends _$FillupList {
  @override
  FutureOr<List<Fillup>> build() {
    return [];
  }

  addFillup(Fillup fillup) {
    final newState = {fillup, ...state.value!}.toList();
    state = AsyncData(newState);
  }
}

@riverpod
List<Fillup> fillupsByWaybill(FillupsByWaybillRef ref, Waybill waybill) {
  final fillups = ref.watch(fillupListProvider).value!;
  return fillups.where((f) => f.waybill == waybill).toList();
}

@riverpod
Fillup? fillupByFalType(FillupByFalTypeRef ref, FALType falType) {
  final fillups = ref.watch(fillupListProvider).value!;
  final fillupsFiltered = fillups.where((f) => f.falType == falType);
  return fillupsFiltered.isEmpty ? null : fillupsFiltered.first;
}

@riverpod
List<FALType> fillupFalTypes(FillupFalTypesRef ref) {
  final fillups = ref.watch(fillupListProvider).value!;
  return {...fillups.map((e) => e.falType)}.toList();
}
