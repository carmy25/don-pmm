import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:donpmm/src/features/outcome/data/outcomes_repository.dart';
import 'package:donpmm/src/widgets/xeditabletable/x_editable_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/cell_entity.dart';
import 'package:flutter_editable_table/entities/table_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutcomeWidget extends ConsumerStatefulWidget {
  const OutcomeWidget({super.key, required this.data});
  final List<Map<String, dynamic>> data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OutcomeWidgetState();
}

class _OutcomeWidgetState extends ConsumerState<OutcomeWidget> {
  final _editableTableKey = GlobalKey<XEditableTableState>();
  Future<Map<String, dynamic>> _getTableData() async {
    final falTypes = await ref.read(falTypesRepositoryProvider.future);
    return {
      "column_count": null,
      "row_count": null,
      "addable": true,
      "removable": true,
      "rows": widget.data,
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
          'format': falTypes.map((e) => e.name).join(','),
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
          "constrains": {"required": false},
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
          "width_factor": 0.20,
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
          "width_factor": 0.2,
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
          "title": "Кількість(л)",
          "type": "float",
          "constrains": {"required": true},
          "format": null,
          "description": "Кількість(л)",
          "display": true,
          "editable": true,
          "width_factor": 0.20,
          "input_decoration": {
            "min_lines": 1,
            "max_lines": 1,
            "max_length": 10,
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
  }

  @override
  Widget build(BuildContext context) {
    final tableData = _getTableData();
    return FutureBuilder<Map<String, dynamic>>(
        future: tableData,
        builder: (BuildContext context, snapshot) => snapshot.hasData
            ? XEditableTable(
                key: _editableTableKey,
                entity: TableEntity.fromJson(snapshot.requireData),
                readOnly: false,
                headerBorder: Border.all(color: const Color(0xFF999999)),
                rowBorder: Border.all(color: const Color(0xFF999999)),
                footerBorder: Border.all(color: const Color(0xFF999999)),
                removeRowIcon: const Icon(
                  Icons.remove_circle_outline,
                  size: 18.0,
                  color: Color.fromARGB(255, 65, 53, 53),
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
                  widget.data.addAll(_editableTableKey
                      .currentState!.currentData.rows
                      .map((e) => e.toJson()));
                  final uuid = row.toJson()['uuid'];
                  if (uuid == null) {
                    return;
                  }
                  ref
                      .read(outcomesRepositoryProvider.notifier)
                      .removeOutcomeByUuid(uuid);
                  debugPrint('row removed: ${row.toString()}');
                },
                onRowAdded: () {},
                onFilling: (FillingArea area, dynamic value) {
                  widget.data.clear();
                  final falTypeString = switch (value) {
                    CellEntity() => value.columnInfo.name,
                    _ => null,
                  };
                  debugPrint('fts: $falTypeString');
                  if (falTypeString == 'comodity') {
                    // set density
                    _editableTableKey.currentState!.currentData.rows[0]
                        .cells![2].value = 14.3;
                    _editableTableKey.currentState!.setState(() {});
                  }
                  widget.data.addAll(_editableTableKey
                      .currentState!.currentData.rows
                      .map((e) => e.toJson()));
                },
                onSubmitted: (FillingArea area, dynamic value) {},
              )
            : const SizedBox(
                width: 60, height: 60, child: CircularProgressIndicator()));
  }
}
