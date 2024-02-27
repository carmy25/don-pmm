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
    state = AsyncData(newState);
  }
}

@riverpod
List<Waybill> waybillsByCar(WaybillsByCarRef ref, Car car) {
  final waybills = ref.watch(waybillListProvider).value!;
  return waybills.where((wb) => wb.carUuid == car.uuid).toList();
}
