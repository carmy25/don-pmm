import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

abstract class BaseDataGridSource<T> extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  final List<T> data;

  /// Helps to hold the new value of all editable widgets.
  /// Based on the new value we will commit the new value into the corresponding
  /// DataGridCell on the onCellSubmit method.
  dynamic newCellValue;

  /// Helps to control the editable text in the [TextField] widget.
  TextEditingController editingController = TextEditingController();

  BaseDataGridSource({required this.data}) {
    updateDataGridRows();
  }

  void updateDataGridRows();

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateDataGridSource() {
    notifyListeners();
  }

  void onDeleteRowPressed(String uuid);

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerRight,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            newCellValue = double.tryParse(value);
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return e.columnName == 'delete'
          ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  final uuid = row.getCells().first.value;
                  dataGridRows = dataGridRows
                      .where(
                          (element) => element.getCells().first.value != uuid)
                      .toList();
                  onDeleteRowPressed(uuid);
                  updateDataGridSource();
                },
              ),
            )
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(e.value.toString()),
            );
    }).toList());
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = rows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return Future.value();
    }
    rows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
        DataGridCell<double>(
            columnName: column.columnName, value: newCellValue);
    onCellSubmitAction(column, dataRowIndex);
    return Future.value();
  }

  void onCellSubmitAction(GridColumn column, int dataRowIndex);
}
