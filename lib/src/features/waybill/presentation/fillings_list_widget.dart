import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/domain/waybill.dart';
import 'package:donpmm/src/widgets/xeditabletable/x_editable_table.dart';
import 'package:flutter/material.dart';

import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/cell_entity.dart';
import 'package:flutter_editable_table/entities/table_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Future<Map<String, dynamic>> _getTableData() async {
    final falTypes = await ref.watch(falTypesRepositoryProvider.future);
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
          "name": "comodity",
          "title": "Назва ПММ",
          "type": "autocomplete",
          'format': falTypes.map((e) => '${e.name}: ${e.density}').join(','),
          "description": "Назва палива чи оливи",
          "display": true,
          "constrains": {"required": true},
          "editable": true,
          "width_factor": 0.33,
          "input_decoration": {
            "min_lines": 1,
            "max_lines": 1,
            "max_length": 128,
            "hint_text": "Паливо/Мастило"
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
        {
          "name": "density",
          "title": "Густина",
          "type": "float",
          "constrains": {"required": true},
          "format": null,
          "description": "Густина(кг/м3)",
          "display": true,
          "editable": true,
          "width_factor": 0.09,
          "input_decoration": {
            "min_lines": 1,
            "max_lines": 1,
            "max_length": 10,
            "hint_text": "Густина(кг/дм3)"
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
        {
          "name": "category",
          "title": "Тип ПММ",
          "type": "choice",
          'format': FALCategory.values.map((e) => e.name).join(','),
          "description": "Тип ПММ",
          "display": true,
          "editable": true,
          "width_factor": 0.15,
          "input_decoration": {
            "min_lines": 1,
            "max_lines": 1,
            "max_length": 128,
            "hint_text": "Тип ПММ"
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
          "title": "Наявність перед виїздом",
          "type": "float",
          "format": null,
          "description": "Наявність перед виїздом(л)",
          "display": true,
          "editable": true,
          "width_factor": 0.09,
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
          "width_factor": 0.09,
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
          "width_factor": 0.09,
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
          "title": "Заправлено в іншому підрозділі?",
          "type": "bool",
          "format": null,
          "description": "Заправлено в іншому підрозділі",
          "display": true,
          "editable": true,
          "width_factor": 0.09,
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
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final fillups = ref.watch(fillupsByWaybillProvider(waybill));
    return FutureBuilder<Map<String, dynamic>>(
      future: _getTableData(),
      builder: (context, snapshot) => snapshot.hasData
          ? _xEditableTable(fillups, snapshot.requireData)
          : const SizedBox(
              width: 60, height: 60, child: CircularProgressIndicator()),
    );
  }

  XEditableTable _xEditableTable(
      List<Fillup> rowsData, Map<String, dynamic> data) {
    data['rows'] = rowsData
        .map((e) => {
              'uuid': e.uuid,
              'comodity': '${e.falType.name}: ${e.falType.density}',
              'density': e.falType.density,
              'category': e.falType.category.name,
              'date': waybill.issueDate,
              'availableLtrs': e.beforeLtrs,
              'gainedLtrs': e.fillupLtrs,
              'spentLtrs': e.burnedLtrs,
              'otherMilBase': e.otherMilBase,
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
        widget.data.clear();
        widget.data.addAll(_editableTableKey.currentState!.currentData.rows
            .map((e) => e.toJson()));
        final uuid = row.toJson()['uuid'];
        if (uuid == null) {
          return;
        }
        ref.watch(fillupListProvider.notifier).removeFillupByUuid(uuid);
      },
      onRowAdded: () {
        debugPrint('row added');
      },
      onFilling: (FillingArea area, dynamic value) {
        widget.data.clear();
        final falTypeString = switch (value) {
          CellEntity() => value.columnInfo.name,
          _ => null,
        };
        debugPrint('fts: ${area.index}: ${area.name}');
        if (falTypeString == 'comodity') {
          // set density and type
          setFalTypeByName((value.value as String),
              _editableTableKey.currentState!.currentData.rows, ref);
          _editableTableKey.currentState!.setState(() {});
        }
        widget.data.addAll(_editableTableKey.currentState!.currentData.rows
            .map((e) => e.toJson()));
      },
      onSubmitted: (FillingArea area, dynamic value) {
        debugPrint('submitted: ${area.toString()}, value: $value}');
      },
    );
  }
}
