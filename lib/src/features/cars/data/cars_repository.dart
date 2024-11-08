import 'package:donpmm/src/features/waybill/data/waybills_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/car.dart';

part 'cars_repository.g.dart';

@Riverpod(keepAlive: true)
class CarList extends _$CarList {
  @override
  List<Car> build() {
    debugPrint('CarListRepo init');
    return [];
  }

  void addCar(Car car) {
    final previousState = state;
    final newState = {car, ...previousState}.toList();
    state = newState;
  }

  clear() {
    state = const [];
  }

  void removeCar(Car car) {
    final previousState = state;
    ref.read(waybillListProvider.notifier).removeWaybillsByCar(car);
    final newState = previousState.where((c) => c != car).toList();
    state = newState;
  }
}

@riverpod
Car carByUuid(Ref ref, String uuid) {
  final cars = ref.watch(carListProvider);
  return cars.where((c) => c.uuid == uuid).first;
}
