import 'package:donpmm/src/widgets/input_form_field.dart';
import 'package:donpmm/src/widgets/subheader_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../waybill/domain/waybill.dart';
import '../../waybill/presentation/waybill_screen.dart';
import '../../waybill/presentation/waybills_list_widget.dart';
import '../data/cars_repository.dart';
import '../domain/car.dart';

// Define a custom Form widget.
class CarForm extends ConsumerStatefulWidget {
  const CarForm({super.key, required this.car});
  final Car car;

  @override
  CarFormState createState() {
    // ignore: no_logic_in_create_state
    return CarFormState(car: car);
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CarFormState extends ConsumerState<CarForm> {
  final TextEditingController nameInput = TextEditingController();
  final TextEditingController numberInput = TextEditingController();
  final TextEditingController _remarkInput = TextEditingController();
  final TextEditingController _consumptionRateInput = TextEditingController();
  final TextEditingController _consumptionRateMHInput = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  CarFormState({required this.car});
  Car car;

  @override
  void initState() {
    super.initState();
  }

  _addCar() {
    ref.read(carListProvider.notifier).addCar(Car(
        uuid: car.uuid,
        name: nameInput.text,
        number: numberInput.text,
        note: _remarkInput.text,
        consumptionRate: double.parse(_consumptionRateInput.text),
        consumptionRateMH: double.parse(_consumptionRateMHInput.text)));
  }

  @override
  Widget build(BuildContext context) {
    nameInput.text = car.name;
    numberInput.text = car.number;
    _remarkInput.text = car.note;
    _consumptionRateInput.text = car.consumptionRate.toString();
    _consumptionRateMHInput.text = car.consumptionRateMH.toString();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  child: InputFormField(
                      controller: nameInput,
                      icon: const Icon(Icons.car_rental), //icon of text field
                      text: 'Марка машини/агрегату' //label text of field
                      )),
              Flexible(
                  child: InputFormField(
                      controller: numberInput,
                      icon: const Icon(Icons.numbers), //icon of text field
                      text: 'Номер машини/агрегату' //label text of field
                      ))
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: InputFormField(
                      isNumeric: true,
                      allowEmpty: true,
                      controller: _consumptionRateInput,
                      icon: const Icon(Icons
                          .production_quantity_limits), //icon of text field
                      text: 'Норма витрати(на 100км)' //label text of field
                      )),
              Flexible(
                  child: InputFormField(
                      isNumeric: true,
                      allowEmpty: true,
                      controller: _consumptionRateMHInput,
                      icon: const Icon(Icons
                          .production_quantity_limits), //icon of text field
                      text: 'Норма витрати(на 1мг)' //label text of field
                      )),
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: InputFormField(
                      allowEmpty: true,
                      controller: _remarkInput,
                      icon: const Icon(Icons.note), //icon of text field
                      text: 'Примітка' //label text of field
                      )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SubheaderText('Шляхові/робочі листи'),
              IconButton(
                icon: const Icon(Icons.add_box_rounded),
                tooltip: 'Додати шляховий/робочий лист',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addCar();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WaybillScreen(
                              waybill: Waybill(
                                  kmsStart: 0,
                                  kmsEnd: 0,
                                  mhStart: 0,
                                  mhEnd: 0,
                                  uuid: const Uuid().v4(),
                                  number: '',
                                  carUuid: car.uuid))),
                    );
                  }
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
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _addCar();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Зберегти'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
