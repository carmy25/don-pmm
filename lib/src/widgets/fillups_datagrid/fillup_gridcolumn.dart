import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FillupGridColumn extends GridColumn {
  FillupGridColumn(
      {required super.columnName,
      required String labelText,
      super.columnWidthMode = ColumnWidthMode.none,
      super.visible = true,
      super.allowSorting = true,
      super.sortIconPosition = ColumnHeaderIconPosition.end,
      super.filterIconPosition = ColumnHeaderIconPosition.end,
      super.autoFitPadding = const EdgeInsets.all(16.0),
      super.minimumWidth = double.nan,
      super.maximumWidth = double.nan,
      super.width = double.nan,
      super.allowEditing = true,
      super.allowFiltering = true,
      super.filterPopupMenuOptions,
      super.filterIconPadding = const EdgeInsets.symmetric(horizontal: 8.0)})
      : super(
          label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(labelText)),
        );
}
