import 'package:flutter/material.dart';

import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/table_entity.dart';
import 'package:flutter_editable_table/flutter_editable_table.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FillingsListWidget extends ConsumerStatefulWidget {
  const FillingsListWidget({super.key});

  @override
  FillingsListWidgetState createState() => FillingsListWidgetState();
}

class FillingsListWidgetState extends ConsumerState {
  final _editableTableKey = GlobalKey<EditableTableState>();
  final data = {
    "column_count": null,
    "row_count": null,
    "addable": true,
    "removable": true,
    "columns": [
      {
        "primary_key": true,
        "name": "id",
        "type": "int",
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
        "type": "string",
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
          "font_size": 14.0,
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
        "width_factor": 0.13,
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
        "width_factor": 0.13,
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
        "width_factor": 0.13,
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
