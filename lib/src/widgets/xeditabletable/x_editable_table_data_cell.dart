import 'package:donpmm/src/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/cell_entity.dart';
import 'package:intl/intl.dart';

class XEditableTableDataCell extends StatefulWidget {
  const XEditableTableDataCell({
    super.key,
    required this.cellEntity,
    required this.cellWidth,
    this.cellContentPadding,
    this.cellInputDecorationContentPadding,
    this.cellHintTextStyle,
    this.cellInputDecorationBorder,
    this.cellInputDecorationFocusBorder,
    this.cellTextStyle,
    this.formFieldAutoValidateMode,
    this.readOnly = false,
    this.onFilling,
    this.onSubmitted,
  });

  final CellEntity cellEntity;
  final double cellWidth;
  final EdgeInsetsGeometry? cellContentPadding;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final TextStyle? cellHintTextStyle;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;
  final TextStyle? cellTextStyle;
  final AutovalidateMode? formFieldAutoValidateMode;
  final bool readOnly;

  final TableFiledFilled<dynamic>? onFilling;
  final TableFiledFilled<dynamic>? onSubmitted;

  @override
  XEditableTableDataCellState createState() => XEditableTableDataCellState();
}

class XEditableTableDataCellState extends State<XEditableTableDataCell> {
  late final TextEditingController _textEditingController;
  String? _dropdownValue;
  late final FocusNode _focusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final val = widget.cellEntity.value?.toString();
    Future.delayed(Duration.zero, () async {
      _textEditingController.text = val ?? '';
    });
    _dropdownValue = val;

    return Container(
      width: widget.cellWidth,
      padding: widget.cellContentPadding ?? const EdgeInsets.all(4.0),
      alignment: widget.cellEntity.columnInfo.style?.horizontalAlignment,
      child: !widget.readOnly &&
              !widget.cellEntity.columnInfo.autoIncrease &&
              widget.cellEntity.columnInfo.editable
          ? _buildWidget(context)
          : (widget.cellEntity.columnInfo.type.toLowerCase() == 'bool'
              ? _buildCheckBox(readOnly: true)
              : Text(
                  widget.cellEntity.value != null
                      ? widget.cellEntity.value.toString()
                      : '',
                  style: widget.cellTextStyle ??
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize:
                                widget.cellEntity.columnInfo.style?.fontSize,
                            color:
                                widget.cellEntity.columnInfo.style?.fontColor,
                          ),
                  textAlign: widget.cellEntity.columnInfo.style?.textAlign,
                )),
    );
  }

  Widget _buildWidget(BuildContext context) {
    switch (widget.cellEntity.columnInfo.type.toLowerCase()) {
      case 'bool':
        return _buildCheckBox();
      case 'date':
        return _buildDatePicker(context);
      case 'datetime':
        return _buildDateTimePicker(context);
      case 'choice':
        return _buildDropdown(context);
      case 'autocomplete':
        return _buildAutocompete(context);
      case 'integer':
      case 'int':
      case 'float':
      case 'double':
      case 'decimal':
      case 'string':
      default:
        return FutureBuilder(
            future: Future.delayed(Duration.zero),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? _buildTextFormField(context)
                : const Text('loading...'));
    }
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      minLines: widget.cellEntity.columnInfo.inputDecoration?.minLines,
      maxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
      maxLength: widget.cellEntity.columnInfo.inputDecoration?.maxLength,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: widget.cellInputDecorationContentPadding ??
            const EdgeInsets.all(8.0),
        hintText: widget.cellEntity.columnInfo.inputDecoration?.hintText,
        hintStyle: widget.cellHintTextStyle,
        hintMaxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
        counterText: '',
        errorMaxLines: 1,
        errorStyle: const TextStyle(fontSize: 0.0, height: 0.0),
        border: widget.cellInputDecorationBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        enabledBorder: widget.cellInputDecorationBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        focusedBorder: widget.cellInputDecorationFocusBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        filled: widget.cellEntity.columnInfo.inputDecoration?.fillColor != null,
        fillColor: widget.cellEntity.columnInfo.inputDecoration?.fillColor,
      ),
      style: widget.cellTextStyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: widget.cellEntity.columnInfo.style?.fontSize,
                color: widget.cellEntity.columnInfo.style?.fontColor,
              ),
      keyboardAppearance: MediaQuery.of(context).platformBrightness,
      validator: (value) {
        return widget.cellEntity.required
            ? (value != null && value.isNotEmpty ? null : '')
            : null;
      },
      autovalidateMode: widget.formFieldAutoValidateMode,
      readOnly: true,
      onTap: () async {
        DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), //get today's date
            firstDate: DateTime(
                2022), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));
        if (date != null) {
          final dateString = DateFormat('yyyy-MM-dd').format(date);
          widget.cellEntity.value = dateString;
          _textEditingController.text = dateString;
          if (widget.onFilling != null) {
            widget.onFilling!(FillingArea.body, dateString);
          }
          if (widget.onSubmitted != null) {
            widget.onSubmitted!(FillingArea.body, dateString);
          }
          return;
        }
        widget.cellEntity.value = null;
        _textEditingController.clear();
        if (widget.onFilling != null) {
          widget.onFilling!(FillingArea.body, null);
        }
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(FillingArea.body, null);
        }
      },
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      minLines: widget.cellEntity.columnInfo.inputDecoration?.minLines,
      maxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
      maxLength: widget.cellEntity.columnInfo.inputDecoration?.maxLength,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: widget.cellInputDecorationContentPadding ??
            const EdgeInsets.all(8.0),
        hintText: widget.cellEntity.columnInfo.inputDecoration?.hintText,
        hintStyle: widget.cellHintTextStyle,
        hintMaxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
        counterText: '',
        errorMaxLines: 1,
        errorStyle: const TextStyle(fontSize: 0.0, height: 0.0),
        border: widget.cellInputDecorationBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        enabledBorder: widget.cellInputDecorationBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        focusedBorder: widget.cellInputDecorationFocusBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        filled: widget.cellEntity.columnInfo.inputDecoration?.fillColor != null,
        fillColor: widget.cellEntity.columnInfo.inputDecoration?.fillColor,
      ),
      style: widget.cellTextStyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: widget.cellEntity.columnInfo.style?.fontSize,
                color: widget.cellEntity.columnInfo.style?.fontColor,
              ),
      keyboardAppearance: MediaQuery.of(context).platformBrightness,
      validator: (value) {
        return widget.cellEntity.required
            ? (value != null && value.isNotEmpty ? null : '')
            : null;
      },
      autovalidateMode: widget.formFieldAutoValidateMode,
      readOnly: true,
      onTap: () {
        DatePickerBdaya.showDateTimePicker(
          context,
          showTitleActions: true,
          onConfirm: (date) {
            final dateString = DateFormat('yyyy-MM-dd HH:mm').format(date);
            widget.cellEntity.value = dateString;
            _textEditingController.text = dateString;
            if (widget.onFilling != null) {
              widget.onFilling!(FillingArea.body, dateString);
            }
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(FillingArea.body, dateString);
            }
          },
          onCancel: () {
            widget.cellEntity.value = null;
            _textEditingController.clear();
            if (widget.onFilling != null) {
              widget.onFilling!(FillingArea.body, null);
            }
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(FillingArea.body, null);
            }
          },
          currentTime: widget.cellEntity.value != null
              ? (DateTime.tryParse(widget.cellEntity.value.toString()) ??
                  DateTime.now())
              : DateTime.now(),
          locale:
              WidgetsBinding.instance.platformDispatcher.locale.countryCode ==
                          'CN' &&
                      WidgetsBinding.instance.platformDispatcher.locale
                              .languageCode ==
                          'zh'
                  ? LocaleType.zh
                  : LocaleType.en,
        );
      },
    );
  }

  Widget _buildCheckBox({bool readOnly = false}) {
    return Checkbox(
      value: widget.cellEntity.value != null && widget.cellEntity.value is bool
          ? widget.cellEntity.value
          : false,
      onChanged: readOnly
          ? null
          : (value) {
              setState(() {
                widget.cellEntity.value = value;
                if (widget.onFilling != null) {
                  widget.onFilling!(FillingArea.body, value);
                }
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!(FillingArea.body, value);
                }
              });
            },
    );
  }

  Widget _buildAutocompete(BuildContext context) {
    final values = widget.cellEntity.columnInfo.format!.split(',');
    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return values.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: _autoCompleteOnChanged,
      textEditingController: _textEditingController,
      focusNode: _focusNode,
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: widget.cellEntity.columnInfo.inputDecoration?.hintText,
          ),
          focusNode: focusNode,
          onChanged: _autoCompleteOnChanged,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(FillingArea.body, value);
            }
          },
          validator: validateNotEmpty,
        );
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _autoCompleteOnChanged(String value) {
    if (value.isEmpty) {
      widget.cellEntity.value = null;
      return;
    }
    widget.cellEntity.value = value;
    if (widget.onFilling != null) {
      widget.onFilling!(FillingArea.body, widget.cellEntity);
    }
  }

  Widget _buildDropdown(BuildContext context) {
    final values = widget.cellEntity.columnInfo.format?.split(',');
    final items = values?.map<DropdownMenuItem<String>>((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList();
    return DropdownButtonFormField<String>(
        style: const TextStyle(fontSize: 12, color: Colors.black),
        isDense: true,
        validator: validateNotEmpty,
        value: _dropdownValue,
        onChanged: (String? newValue) {
          setState(() {
            widget.cellEntity.value = newValue;
            _dropdownValue = newValue!;
          });
        },
        hint: Text(widget.cellEntity.columnInfo.description),
        items: items);
  }

  Widget _buildTextFormField(BuildContext context) {
    TextInputType? textInputType;
    switch (widget.cellEntity.columnInfo.type.toLowerCase()) {
      case 'integer':
      case 'int':
        textInputType = TextInputType.numberWithOptions(
            signed: widget.cellEntity.columnInfo.constrains != null &&
                    widget.cellEntity.columnInfo.constrains!.minimum != null &&
                    widget.cellEntity.columnInfo.constrains!.minimum! >= 0
                ? false
                : true);
        break;
      case 'float':
      case 'double':
      case 'decimal':
        textInputType = TextInputType.numberWithOptions(
            signed: widget.cellEntity.columnInfo.constrains != null &&
                    widget.cellEntity.columnInfo.constrains!.minimum != null &&
                    widget.cellEntity.columnInfo.constrains!.minimum! >= 0
                ? false
                : true,
            decimal: true);
        break;
    }
    return TextFormField(
      controller: _textEditingController,
      minLines: widget.cellEntity.columnInfo.inputDecoration?.minLines,
      maxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
      maxLength: widget.cellEntity.columnInfo.inputDecoration?.maxLength,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: widget.cellInputDecorationContentPadding ??
            const EdgeInsets.all(8.0),
        hintText: widget.cellEntity.columnInfo.inputDecoration?.hintText,
        hintStyle: widget.cellHintTextStyle,
        hintMaxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
        counterText: '',
        errorMaxLines: 1,
        errorStyle: const TextStyle(fontSize: 0.0, height: 0.0),
        border: widget.cellInputDecorationBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        enabledBorder: widget.cellInputDecorationBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        focusedBorder: widget.cellInputDecorationFocusBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            ),
        filled: widget.cellEntity.columnInfo.inputDecoration?.fillColor != null,
        fillColor: widget.cellEntity.columnInfo.inputDecoration?.fillColor,
      ),
      style: widget.cellTextStyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: widget.cellEntity.columnInfo.style?.fontSize,
                color: widget.cellEntity.columnInfo.style?.fontColor,
              ),
      keyboardAppearance: MediaQuery.of(context).platformBrightness,
      keyboardType: textInputType,
      validator: (value) {
        return widget.cellEntity.required
            ? (value != null && value.isNotEmpty ? null : '')
            : null;
      },
      autovalidateMode: widget.formFieldAutoValidateMode,
      onChanged: (String value) {
        if (value.isEmpty) {
          widget.cellEntity.value = null;
          return;
        }
        if (['integer', 'int']
            .contains(widget.cellEntity.columnInfo.type.toLowerCase())) {
          final finalValue = int.tryParse(value);
          if (finalValue != null) {
            if (widget.cellEntity.columnInfo.constrains != null &&
                widget.cellEntity.columnInfo.constrains!.maximum != null &&
                finalValue >
                    widget.cellEntity.columnInfo.constrains!.maximum!) {
              widget.cellEntity.value =
                  widget.cellEntity.columnInfo.constrains!.maximum!;
            } else {
              widget.cellEntity.value = finalValue;
            }
          } else {
            widget.cellEntity.value = 0;
            _textEditingController.text = 0.toString();
          }
        } else if (['float', 'double', 'decimal']
            .contains(widget.cellEntity.columnInfo.type.toLowerCase())) {
          final finalValue = double.tryParse(value);
          if (finalValue != null) {
            if (widget.cellEntity.columnInfo.constrains != null &&
                widget.cellEntity.columnInfo.constrains!.maximum != null &&
                finalValue >
                    widget.cellEntity.columnInfo.constrains!.maximum!) {
              widget.cellEntity.value =
                  widget.cellEntity.columnInfo.constrains!.maximum!;
            } else {
              widget.cellEntity.value = finalValue;
            }
          } else {
            Future.delayed(Duration.zero, () async {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.cellEntity.value = 0.0;
                _textEditingController.text = (0.0).toString();
              });
            });
          }
        } else {
          widget.cellEntity.value = value;
        }
        if (widget.onFilling != null) {
          widget.onFilling!(FillingArea.body, value);
        }
      },
      onFieldSubmitted: (value) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(FillingArea.body, value);
        }
      },
    );
  }
}
