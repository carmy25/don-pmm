import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../cars/domain/car.dart';
import '../domain/waybill.dart';

part 'waybills_repository.g.dart';

@Riverpod(keepAlive: true)
class WaybillList extends _$WaybillList {
  @override
  List<Waybill> build() {
    return [];
  }

  void addWaybill(Waybill waybill) {
    final newState = {waybill, ...state}.toList();
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
    state = newState;
  }

  clear() {
    state = [];
  }

  void removeWaybillsByCar(Car car) {
    final newState = state.where((wb) => wb.carUuid != car.uuid).toList();
    for (final wb in state.where((wb) => wb.carUuid == car.uuid).toList()) {
      ref.read(fillupListProvider.notifier).removeFillupsByWaybill(wb);
    }
    state = newState;
  }

  void removeWaybill(Waybill wb) {
    final newState = state.where((w) => w.uuid != wb.uuid).toList();
    ref.read(fillupListProvider.notifier).removeFillupsByWaybill(wb);
    state = newState;
  }
}

@riverpod
List<Waybill> waybillsByCar(Ref ref, Car car) {
  final waybills = ref.watch(waybillListProvider);
  return waybills.where((wb) => wb.carUuid == car.uuid).toList();
}

@riverpod
Waybill? waybillByUuid(Ref ref, String uuid) {
  final waybills = ref.watch(waybillListProvider);
  return waybills.where((wb) => wb.uuid == uuid).firstOrNull!;
}

@riverpod
List<Waybill> waybillsByCarAndDate(Ref ref, Car car, DateTime after) {
  final waybills = ref.read(waybillsByCarProvider(car));
  return waybills
      .where((wb) =>
          wb.issueDate!.isAfter(after.subtract(const Duration(days: 1))))
      .toList();
}

@riverpod
List<Waybill> waybillsByDate(Ref ref, DateTime after) {
  final waybills = ref.watch(waybillListProvider);
  return waybills
      .where((wb) =>
          wb.issueDate!.isAfter(after.subtract(const Duration(days: 1))))
      .toList();
}
