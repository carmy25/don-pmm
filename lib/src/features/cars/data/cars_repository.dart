import 'package:donpmm/src/features/waybill/data/waybills_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/car.dart';

part 'cars_repository.g.dart';

@Riverpod(keepAlive: true)
class CarList extends _$CarList {
  @override
  FutureOr<List<Car>> build() {
    debugPrint('CarListRepo init');
    return [];
  }

  Future<void> addCar(Car car) async {
    final previousState = await future;
    final newState = {car, ...previousState}.toList();
    state = AsyncData(newState);
  }

  clear() {
    state = const AsyncData([]);
  }

  Future<void> removeCar(Car car) async {
    final previousState = await future;
    ref.read(waybillListProvider.notifier).removeWaybillsByCar(car);
    final newState = previousState.where((c) => c != car).toList();
    state = AsyncData(newState);
  }
}

@riverpod
Car carByUuid(CarByUuidRef ref, String uuid) {
  final cars = ref.watch(carListProvider).value!;
  return cars.where((c) => c.uuid == uuid).first;
}
