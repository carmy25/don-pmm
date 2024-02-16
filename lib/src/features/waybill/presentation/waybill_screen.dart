import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/table_entity.dart';
import 'package:flutter_editable_table/flutter_editable_table.dart';

import '../data/waybills_repository.dart';
import '../domain/waybill.dart';

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

  final _editableTableKey = GlobalKey<EditableTableState>();
  final Map<String, dynamic> _data = {};
  final data = {
    "column_count": null,
    "row_count": null,
    "addable": true,
    "removable": true,
    "columns": [
      {
        "name": "comodity",
        "title": "Паливо/Олива",
        "type": "string",
        "format": null,
        "description": "Назва палива чи оливи",
        "display": true,
        "editable": true,
        "width_factor": 0.33,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Паливо/Мастило"
        },
        "constrains": {"required": true},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "availableLtrs",
        "title": "Наявність перед виїздом",
        "type": "integer",
        "format": null,
        "description": "Наявність перед виїздом(л)",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 3,
          "hint_text": "Наявність перед виїздом(л)"
        },
        "constrains": {"required": true, "minimum": 1, "maximum": 120},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "gainedLtrs",
        "title": "Отримано",
        "type": "float",
        "format": null,
        "description": "Отримано(л)",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Отримано(л)"
        },
        "constrains": {"required": true, "minimum": -100, "maximum": 10000},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "spentLtrs",
        "title": "Витрачено",
        "type": "float",
        "format": null,
        "description": "Витрачено(л)",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {"hint_text": "Витрачено(л)"},
        "style": {
          "font_weight": "bold",
          "font_size": 14.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
    ],
    "rows": []
  };

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
            SingleChildScrollView(
              child: EditableTable(
                key: _editableTableKey,
                data: _data,
                entity: TableEntity.fromJson(data),
                readOnly: false,
                tablePadding: EdgeInsets.all(8.0),
                headerBorder: Border.all(color: Color(0xFF999999)),
                rowBorder: Border.all(color: Color(0xFF999999)),
                footerBorder: Border.all(color: Color(0xFF999999)),
                removeRowIcon: Icon(
                  Icons.remove_circle_outline,
                  size: 18.0,
                  color: Colors.redAccent,
                ),
                addRowIcon: Icon(
                  Icons.add_circle_outline,
                  size: 18.0,
                  color: Colors.white,
                ),
                addRowIconContainerBackgroundColor: Colors.blueAccent,
                formFieldAutoValidateMode: AutovalidateMode.always,
                onRowRemoved: (row) {
                  print('row removed: ${row.toString()}');
                },
                onRowAdded: () {
                  print('row added');
                },
                onFilling: (FillingArea area, dynamic value) {
                  print(_editableTableKey.currentState?.currentData);

                  print(
                      'filling: ${area.toString()}, value: ${value.toString()}');
                },
                onSubmitted: (FillingArea area, dynamic value) {
                  print(
                      'submitted: ${area.toString()}, value: ${value.toString()}');
                },
              ),
            ),
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
