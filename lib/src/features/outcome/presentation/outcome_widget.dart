import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/features/outcome/data/outcomes_repository.dart';
import 'package:donpmm/src/widgets/xeditabletable/x_editable_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_editable_table/constants.dart';
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
        "type": "choice",
        'format': FALType.values.map((e) => e.name).join(','),
        "description": "Назва палива чи оливи",
        "display": true,
        "editable": true,
        "width_factor": 0.73,
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
        "name": "availableLtrs",
        "title": "Кількість(л)",
        "type": "float",
        "constrains": {"required": false},
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
  @override
  Widget build(BuildContext context) {
    data['rows'] = widget.data;
    return XEditableTable(
      key: _editableTableKey,
      entity: TableEntity.fromJson(data),
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
        widget.data.addAll(_editableTableKey.currentState!.currentData.rows
            .map((e) => e.toJson()));
        final uuid = row.toJson()['uuid'];
        if (uuid == null) {
          return;
        }
        ref.read(outcomesRepositoryProvider.notifier).removeOutcomeByUuid(uuid);
        debugPrint('row removed: ${row.toString()}');
      },
      onRowAdded: () {},
      onFilling: (FillingArea area, dynamic value) {
        widget.data.clear();
        widget.data.addAll(_editableTableKey.currentState!.currentData.rows
            .map((e) => e.toJson()));
      },
      onSubmitted: (FillingArea area, dynamic value) {},
    );
  }
}
