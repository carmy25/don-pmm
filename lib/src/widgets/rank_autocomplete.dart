import 'package:donpmm/src/common/rank.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:flutter/material.dart';

class RankAutoComplete extends StatelessWidget {
  const RankAutoComplete({
    super.key,
    required TextEditingController rankInput,
    required FocusNode rankNode,
  })  : _rankInput = rankInput,
        _rankNode = rankNode;

  final TextEditingController _rankInput;
  final FocusNode _rankNode;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return ranks.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      textEditingController: _rankInput,
      focusNode: _rankNode,
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            labelText: 'Звання',
            icon: Icon(Icons.military_tech),
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
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
}
