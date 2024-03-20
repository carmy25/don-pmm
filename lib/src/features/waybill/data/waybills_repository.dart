import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../cars/domain/car.dart';
import '../domain/waybill.dart';

part 'waybills_repository.g.dart';

@Riverpod(keepAlive: true)
class WaybillList extends _$WaybillList {
  @override
  FutureOr<List<Waybill>> build() {
    return [];
  }

  void addWaybill(Waybill waybill) {
    final newState = {waybill, ...state.value!}.toList();
    newState.sort(
      (a, b) {
        final aIssueDate = a.issueDate;
        final bIssueDate = b.issueDate;
        if (aIssueDate == null || bIssueDate == null) {
          return 1;
        }
        return aIssueDate.compareTo(bIssueDate);
      },
    );
    state = AsyncData(newState);
  }

  clear() {
    state = const AsyncData([]);
  }

  void removeWaybillsByCar(Car car) {
    final newState =
        state.value!.where((wb) => wb.carUuid != car.uuid).toList();
    for (final wb
        in state.value!.where((wb) => wb.carUuid == car.uuid).toList()) {
      ref.read(fillupListProvider.notifier).removeFillupsByWaybill(wb);
    }
    state = AsyncData(newState);
  }
}

@riverpod
List<Waybill> waybillsByCar(WaybillsByCarRef ref, Car car) {
  final waybills = ref.watch(waybillListProvider).value!;
  return waybills.where((wb) => wb.carUuid == car.uuid).toList();
}

@riverpod
Waybill waybillByUuid(WaybillByUuidRef ref, String uuid) {
  final waybills = ref.watch(waybillListProvider).value!;
  return waybills.where((wb) => wb.uuid == uuid).firstOrNull!;
}

@riverpod
List<Waybill> waybillsByCarAndDate(
    WaybillsByCarAndDateRef ref, Car car, DateTime after) {
  final waybills = ref.read(waybillsByCarProvider(car));
  return waybills
      .where((wb) =>
          wb.issueDate!.isAfter(after.subtract(const Duration(days: 1))))
      .toList();
}

@riverpod
List<Waybill> waybillsByDate(WaybillsByDateRef ref, DateTime after) {
  final waybills = ref.watch(waybillListProvider).value!;
  return waybills
      .where((wb) =>
          wb.issueDate!.isAfter(after.subtract(const Duration(days: 1))))
      .toList();
}
