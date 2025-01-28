import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

abstract class BaseDataGridWidget extends ConsumerStatefulWidget {
  const BaseDataGridWidget({super.key});
}

abstract class BaseDataGridState<T extends BaseDataGridWidget>
    extends ConsumerState<T> {
  final formKey = GlobalKey<FormState>();
  final densityInput = TextEditingController();
  final categoryInput = TextEditingController();

  String? falName;

  @override
  void dispose() {
    densityInput.dispose();
    categoryInput.dispose();
    super.dispose();
  }

  Future<FALType> createNewFalType(
      String name, double density, FALCategory category) async {
    final falTypesRepo = ref.read(falTypesRepositoryProvider.notifier);
    final falType = FALType(
        uuid: const Uuid().v4(),
        name: name.split(':').first,
        density: density,
        category: category);
    await falTypesRepo.addFalType(falType);
    return falType;
  }

  List<Widget> buildNewFillupDialogActions(Function onConfirm) {
    return <Widget>[
      TextButton(
        child: Text('Відмінити'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text('Додати'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            onConfirm();
            Navigator.pop(context);
          }
        },
      ),
    ];
  }

  Future<void> displayTextInputDialog(
      BuildContext context, List<FALType> falTypes, Function onConfirm) async {
    final width = MediaQuery.of(context).size.width;
    final falCategories = falTypes.map((e) => e.category.name).toSet().toList();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('Нова заправка'),
            content: SizedBox(
              width: width - 100,
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Autocomplete<String>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable<String>.empty();
                                }
                                return falTypes.where((FALType ft) {
                                  return ft.name.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase());
                                }).map((FALType ft) =>
                                    '${ft.name}: ${ft.density}');
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController textEditingController,
                                  FocusNode focusNode,
                                  VoidCallback onFieldSubmitted) {
                                focusNode.addListener(() {
                                  if (!focusNode.hasFocus) {
                                    debugPrint('Focus lost');
                                    setState(() {
                                      falName = textEditingController.text;
                                    });
                                    onFieldSubmitted();
                                  }
                                });
                                return TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    labelText: 'Тип палива',
                                    icon: const Icon(Icons.local_gas_station),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Вкажіть тип палива';
                                    }
                                    return null;
                                  },
                                );
                              },
                              onSelected: (String selection) {
                                setState(() {
                                  falName = selection;
                                });
                                falName = selection;
                                final [name, ...density] = falName!.split(':');
                                final densityStr =
                                    density.isEmpty ? '' : density[0];
                                densityInput.text = densityStr;
                                final falType = ref.read(
                                    falTypeByNameAndDensityProvider(name,
                                        density: double.tryParse(densityStr)));
                                if (falType != null) {
                                  categoryInput.text = falType.category.name;
                                }

                                debugPrint('You just selected $selection');
                              },
                            ),
                          ),
                          Flexible(
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: densityInput,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}'))
                                  ],
                                  validator: validateNotEmptyNumber,
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.density_small),
                                      labelText: 'Густина'))),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownMenu<String>(
                                initialSelection: falCategories.first,
                                controller: categoryInput,
                                onSelected: (String? value) {
                                  // This is called when the user selects an item.
                                },
                                dropdownMenuEntries: falCategories
                                    .map<DropdownMenuEntry<String>>(
                                        (String value) {
                                  return DropdownMenuEntry<String>(
                                    value: value,
                                    label: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                      buildNewFillupDialogInputs(),
                    ],
                  )),
            ),
            actions: buildNewFillupDialogActions(onConfirm));
      },
    );
  }

  Widget buildNewFillupDialogInputs();
}
