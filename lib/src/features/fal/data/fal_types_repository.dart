import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:convert';

part 'fal_types_repository.g.dart';

@Riverpod(keepAlive: true)
class FalTypesRepository extends _$FalTypesRepository {
  @override
  FutureOr<List<FALType>> build() async {
    final jsonString =
        await rootBundle.loadString('assets/default_fal_types.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    return jsonData.map((item) => FALType.fromJson(item)).toList();
  }

  addFalType(FALType falType) async {
    final prevState = await future;
    state = AsyncData([...prevState, falType]);
  }
}
