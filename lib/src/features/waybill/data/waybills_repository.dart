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
    if (!previousState.contains(waybill)) {
      state = AsyncData([...previousState, waybill]);
    } else {
      final tmpState = [...previousState];
      state = AsyncData(tmpState);
    }
  }
}

@riverpod
Future<List<Waybill>> waybillsByCar(WaybillsByCarRef ref, Car car) async {
  final waybills = await ref.watch(waybillListProvider.future);
  return waybills.where((wb) => wb.car == car).toList();
}
