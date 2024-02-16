import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../cars/domain/car.dart';
import '../domain/waybill.dart';

part 'waybills_repository.g.dart';

//XXX: if car not saved, waybill anyway leaves in memory
@Riverpod(keepAlive: true)
class WaybillList extends _$WaybillList {
  @override
  FutureOr<List<Waybill>> build() {
    return [];
  }

  Future<void> addWaybill(Waybill waybill) async {
    final previousState = await future;
    final newState = {waybill, ...previousState}.toList();
    state = AsyncData(newState);
  }
}

@riverpod
Future<List<Waybill>> waybillsByCar(WaybillsByCarRef ref, Car car) async {
  final waybills = await ref.watch(waybillListProvider.future);
  return waybills.where((wb) => wb.car == car).toList();
}
