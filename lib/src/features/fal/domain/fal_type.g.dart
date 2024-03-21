// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fal_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FALTypeImpl _$$FALTypeImplFromJson(Map<String, dynamic> json) =>
    _$FALTypeImpl(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      category: $enumDecode(_$FALCategoryEnumMap, json['category']),
      density: (json['density'] as num).toDouble(),
    );

Map<String, dynamic> _$$FALTypeImplToJson(_$FALTypeImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'category': _$FALCategoryEnumMap[instance.category]!,
      'density': instance.density,
    };

const _$FALCategoryEnumMap = {
  FALCategory.diesel: 'diesel',
  FALCategory.petrol: 'petrol',
  FALCategory.oil: 'oil',
};
