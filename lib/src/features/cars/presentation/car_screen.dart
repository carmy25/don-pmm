import 'package:donpmm/src/features/cars/presentation/car_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/car.dart';

class CarScreen extends ConsumerStatefulWidget {
  const CarScreen({super.key, required this.car});
  final Car car;

  @override
  // ignore: no_logic_in_create_state
  CarScreenState createState() => CarScreenState(car: car);
}

class CarScreenState extends ConsumerState {
  Car car;

  CarScreenState({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Машина'),
        ),
        body: Container(
            padding: const EdgeInsets.all(8.0), child: CarForm(car: car)));
  }
}
