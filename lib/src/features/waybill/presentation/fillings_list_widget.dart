import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/domain/waybill.dart';
import 'package:donpmm/src/widgets/x_editable_table.dart';
import 'package:flutter/material.dart';

import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/table_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../domain/fillup.dart';

class FillingsListWidget extends ConsumerStatefulWidget {
  const FillingsListWidget(
      {super.key, required this.data, required this.waybill});
  final List<Map<String, dynamic>> data;
  final Waybill waybill;

  @override
  FillingsListWidgetState createState() =>
      // ignore: no_logic_in_create_state
      FillingsListWidgetState(waybill: waybill);
}

class FillingsListWidgetState extends ConsumerState<FillingsListWidget> {
  FillingsListWidgetState({required this.waybill});
  final Waybill waybill;
  final _editableTableKey = GlobalKey<XEditableTableState>();
  final data = {
    "column_count": null,
    "row_count": null,
    "addable": true,
    "removable": true,
    "columns": [
      {
        "primary_key": true,
        "name": "uuid",
        "type": "string",
        "format": null,
        "description": null,
        "display": false,
        "editable": false,
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
        "name": "date",
        "title": "Дата",
        "type": "date",
        "format": null,
        "description": "Дата заправки",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Дата заправки"
        },
        "constrains": {"required": true},
        "style": {
          "font_weight": "bold",
          "font_size": 12.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        }
      },
      {
        "name": "comodity",
        "title": "Паливо/Олива",
        "type": "choice",
        'format': FALType.values.map((e) => e.name).join(','),
        "description": "Назва палива чи оливи",
        "display": true,
        "editable": true,
        "width_factor": 0.23,
        "constrains": {"required": true},
        "style": {
          "font_weight": "bold",
          "font_size": 12.0,
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
        "type": "float",
        "format": null,
        "description": "Наявність перед виїздом(л)",
        "display": true,
        "editable": true,
        "width_factor": 0.1,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 4,
          "hint_text": "Наявність перед виїздом(л)"
        },
        "constrains": {"minimum": 0},
        "style": {
          "font_weight": "bold",
          "font_size": 12.0,
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
        "width_factor": 0.1,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 12,
          "hint_text": "Отримано(л)"
        },
        "constrains": {"required": true, "minimum": 0},
        "style": {
          "font_weight": "bold",
          "font_size": 12.0,
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
        "constrains": {"required": true, "minimum": 0},
        "description": "Витрачено(л)",
        "display": true,
        "editable": true,
        "width_factor": 0.1,
        "input_decoration": {"hint_text": "Витрачено(л)"},
        "style": {
          "font_weight": "bold",
          "font_size": 12.0,
          "font_color": "#333333",
          "background_color": "#b5cfd2",
          "horizontal_alignment": "center",
          "vertical_alignment": "center",
          "text_align": "center"
        },
      },
      {
        "primary_key": false,
        "auto_increase": false,
        "name": "otherMilBase",
        "title": "Видано в іншій в/ч?",
        "type": "bool",
        "format": null,
        "description": "Видано в іншій в/ч?",
        "display": true,
        "editable": true,
        "width_factor": 0.1,
        "constrains": {"minimum": 1, "maximum": 100},
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
  };

  @override
  Widget build(BuildContext context) {
    final fillups = ref.watch(fillupsByWaybillProvider(waybill));
    return _xEditableTable(fillups);
    /*
    return switch (fillups) {
      AsyncData(:final value) => _xEditableTable(value),
      AsyncError(:final error) => Text('error: $error'),
      _ => const Text('loading'),
    };*/
  }

  XEditableTable _xEditableTable(List<Fillup> rowsData) {
    data['rows'] = rowsData
        .map((e) => {
              'uuid': e.uuid,
              'comodity': e.falType.name,
              'date': DateFormat('yyyy-MM-dd').format(e.date),
              'availableLtrs': e.beforeLtrs,
              'gainedLtrs': e.fillupLtrs,
              'spentLtrs': e.burnedLtrs
            })
        .toList();
    final jsonData = TableEntity.fromJson(data);
    return XEditableTable(
      key: _editableTableKey,
      entity: jsonData,
      readOnly: false,
      headerBorder: Border.all(color: const Color(0xFF999999)),
      rowBorder: Border.all(color: const Color(0xFF999999)),
      footerBorder: Border.all(color: const Color(0xFF999999)),
      removeRowIcon: const Icon(
        Icons.remove_circle_outline,
        size: 18.0,
        color: Colors.redAccent,
      ),
      addRowIcon: const Icon(
        Icons.add_circle_outline,
        size: 18.0,
        color: Colors.white,
      ),
      addRowIconContainerBackgroundColor: Colors.blueAccent,
      formFieldAutoValidateMode: AutovalidateMode.always,
      onRowRemoved: (row) {
        debugPrint('row removed: ${row.toString()}');
      },
      onRowAdded: () {
        debugPrint('row added');
      },
      onFilling: (FillingArea area, dynamic value) {
        debugPrint('filling: ${area.toString()}, value: ${value.toString()}');
        widget.data.clear();
        widget.data.addAll(_editableTableKey.currentState!.currentData.rows
            .map((e) => e.toJson()));
      },
      onSubmitted: (FillingArea area, dynamic value) {
        debugPrint('submitted: ${area.toString()}, value: ${value.toString()}');
      },
    );
  }
}
