import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/waybills_repository.dart';
import '../domain/waybill.dart';
import 'fillings_list_widget.dart';

class WaybillScreen extends ConsumerStatefulWidget {
  const WaybillScreen({super.key, required this.waybill});
  final Waybill waybill;

  @override
  // ignore: no_logic_in_create_state
  WaybillScreenState createState() => WaybillScreenState(waybill: waybill);
}

class WaybillScreenState extends ConsumerState {
  final TextEditingController numberInput = TextEditingController();
  final Waybill waybill;

  WaybillScreenState({required this.waybill});

  @override
  Widget build(BuildContext context) {
    numberInput.text = waybill.number;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шляховий лист'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                    child: TextField(
                  controller: numberInput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.numbers), //icon of text field
                      labelText: 'Номер листа' //label text of field
                      ),
                ))
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 14, bottom: 2),
                    child: Text('Заправки',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
              ],
            ),
            const Flexible(
                child: SingleChildScrollView(child: FillingsListWidget())),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(waybillListProvider.notifier).addWaybill(Waybill(
                          uuid: waybill.uuid,
                          car: waybill.car,
                          number: numberInput.text));
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
