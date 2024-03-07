import 'package:donpmm/src/features/cars/data/cars_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'car_screen.dart';

class CarsListWidget extends ConsumerWidget {
  const CarsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(carListProvider);
    return switch (cars) {
      AsyncData(:final value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (_, i) {
            final car = value[i];
            return ListTile(
              leading: const Icon(Icons.car_rental),
              title: Text(car.name),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Видалити машину',
                onPressed: () {
                  debugPrint('delete car: ${car.uuid}');
                  ref.read(carListProvider.notifier).removeCar(car);
                },
              ),
              subtitle: Text(car.number),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarScreen(car: car)),
                );
              }, // Handle your onTap here.
            );
          },
        ),
      AsyncError(:final error) => Text('error: $error'),
      _ => const Text('loading'),
    };
  }
}
