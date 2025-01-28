import 'package:donpmm/src/features/cars/presentation/car_screen.dart';
import 'package:donpmm/src/features/cars/presentation/cars_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../domain/car.dart';

class CarsListScreen extends ConsumerStatefulWidget {
  const CarsListScreen({super.key});

  @override
  CarsListScreenState createState() => CarsListScreenState();
}

class CarsListScreenState extends ConsumerState {
  CarsListScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Машини/Робочі агрегати'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_box_rounded),
              tooltip: 'Додати нову машину/агрегат',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CarScreen(
                            car: Car(
                              uuid: const Uuid().v4(),
                              underRepair: false,
                              name: '',
                              number: '',
                              note: '',
                              consumptionRate: 0,
                              consumptionRateMH: 0,
                            ),
                          )),
                );
              },
            ),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(8.0), child: const CarsListWidget()));
  }
}
