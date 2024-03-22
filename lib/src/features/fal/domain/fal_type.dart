import 'package:freezed_annotation/freezed_annotation.dart';

part 'fal_type.freezed.dart';
part 'fal_type.g.dart';

enum FALCategory {
  @JsonValue('diesel')
  diesel(name: 'Дизель'),

  @JsonValue('petrol')
  petrol(name: 'Бензин'),

  @JsonValue('oil')
  oil(name: 'Олива');

  const FALCategory({required this.name});

  final String name;
}

@freezed
class FALType with _$FALType {
  factory FALType(
      {required String uuid,
      required String name,
      required FALCategory category,
      required double density}) = _FALType;
  factory FALType.fromJson(Map<String, dynamic> json) =>
      _$FALTypeFromJson(json);
}
