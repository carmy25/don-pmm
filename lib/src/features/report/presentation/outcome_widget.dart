import 'package:flutter/material.dart';
import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/table_entity.dart';
import 'package:flutter_editable_table/flutter_editable_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutcomeWidget extends ConsumerStatefulWidget {
  const OutcomeWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OutcomeWidgetState();
}

class _OutcomeWidgetState extends ConsumerState<OutcomeWidget> {
  final _editableTableKey = GlobalKey<EditableTableState>();
  final data = {
    "column_count": null,
    "row_count": null,
    "addable": true,
    "removable": true,
    "columns": [
      {
        "name": "comodity",
        "title": "Назва ПММ",
        "type": "string",
        "format": null,
        "description": "Назва палива чи оливи",
        "display": true,
        "editable": true,
        "width_factor": 0.75,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 128,
          "hint_text": "Паливо/Мастило"
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
        "name": "availableLtrs",
        "title": "Кількість(л)",
        "type": "string",
        "constrains": {"required": true},
        "format": null,
        "description": "Кількість(л)",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {
          "min_lines": 1,
          "max_lines": 1,
          "max_length": 5,
          "hint_text": "Кількість(л)"
        },
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
    ]
  };
  @override
  Widget build(BuildContext context) {
    return EditableTable(
      key: _editableTableKey,
      entity: TableEntity.fromJson(data),
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
      },
      onSubmitted: (FillingArea area, dynamic value) {
        debugPrint('submitted: ${area.toString()}, value: ${value.toString()}');
      },
    );
  }
}
