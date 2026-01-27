// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TargetCaloriesProtocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TargetCaloriesProtocol _$TargetCaloriesProtocolFromJson(
  Map<String, dynamic> json,
) => _TargetCaloriesProtocol(
  calories: (json['calories'] as num).toInt(),
  protein: (json['protein'] as num).toInt(),
  carbs: (json['carbs'] as num).toInt(),
  fat: (json['fat'] as num).toInt(),
);

Map<String, dynamic> _$TargetCaloriesProtocolToJson(
  _TargetCaloriesProtocol instance,
) => <String, dynamic>{
  'calories': instance.calories,
  'protein': instance.protein,
  'carbs': instance.carbs,
  'fat': instance.fat,
};
