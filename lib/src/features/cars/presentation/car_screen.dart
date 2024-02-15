import 'package:donpmm/src/features/cars/data/cars_repository.dart';
import 'package:donpmm/src/features/waybill/presentation/waybill_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../waybill/domain/waybill.dart';
import '../../waybill/presentation/waybills_list_widget.dart';
import '../domain/car.dart';

class CarScreen extends ConsumerStatefulWidget {
  const CarScreen({super.key, required this.car});
  final Car car;

  @override
  // ignore: no_logic_in_create_state
  CarScreenState createState() => CarScreenState(car: car);
}

class CarScreenState extends ConsumerState {
  final TextEditingController nameInput = TextEditingController();
  final TextEditingController numberInput = TextEditingController();
  Car car;

  CarScreenState({required this.car});

  @override
  Widget build(BuildContext context) {
    nameInput.text = car.name;
    numberInput.text = car.number;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Машина'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                    child: TextField(
                  controller: nameInput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.car_rental), //icon of text field
                      labelText: 'Марка машини' //label text of field
                      ),
                )),
                Flexible(
                    child: TextField(
                  controller: numberInput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.numbers), //icon of text field
                      labelText: 'Номер машини' //label text of field
                      ),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 14, bottom: 14),
                    child: Text('Шляхові листи',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
                IconButton(
                  icon: const Icon(Icons.add_box_rounded),
                  tooltip: 'Додати шляховий лист',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WaybillScreen(
                              waybill: Waybill(number: '', car: car))),
                    );
                  },
                ),
              ],
            ),
            Flexible(child: WaybillsListWidget(car: car)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    onPressed: () {
                      car.name = nameInput.text;
                      car.number = numberInput.text;
                      ref.read(carListProvider.notifier).addCar(car);
                      Navigator.pop(context);
                    },
                    child: const Text('Зберегти'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
