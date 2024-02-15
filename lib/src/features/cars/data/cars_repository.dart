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
    if (!previousState.contains(car)) {
      state = AsyncData([...previousState, car]);
    } else {
      final tmpState = [...previousState];
      state = AsyncData(tmpState);
    }
  }
}
