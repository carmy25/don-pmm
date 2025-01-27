import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:riverpod/riverpod.dart';
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

  void addFillup(Fillup fillup) {
    final newState = {fillup, ...state.value!}.toList();
    state = AsyncData(newState);
  }

  void clear() {
    state = const AsyncData([]);
  }

  removeFillupByUuid(String uuid) {
    final newState = state.value!.where((fu) => fu.uuid != uuid).toList();
    state = AsyncData(newState);
  }

  removeFillupsByWaybill(Waybill waybill) {
    final newState =
        state.value!.where((fu) => fu.waybill != waybill.uuid).toList();
    state = AsyncData(newState);
  }
}

@riverpod
List<Fillup> fillupsByWaybill(Ref ref, Waybill waybill) {
  final fillups = ref.watch(fillupListProvider).value!;
  return fillups.where((f) => f.waybill == waybill.uuid).toList();
}

@riverpod
List<Fillup> fillupsByFalType(Ref ref, FALType falType) {
  final fillups = ref.watch(fillupListProvider).value!;
  final fillupsFiltered = fillups.where((f) => f.falType == falType);
  return fillupsFiltered.toList();
}

@riverpod
List<FALType> fillupFalTypes(Ref ref) {
  final fillups = ref.watch(fillupListProvider).value!;
  return {...fillups.map((e) => e.falType)}.toList();
}
