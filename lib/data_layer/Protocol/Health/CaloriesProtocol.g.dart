// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CaloriesProtocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaloriesProtocol _$CaloriesProtocolFromJson(Map<String, dynamic> json) =>
    _CaloriesProtocol(
      calories: (json['calories'] as num).toInt(),
      protein: (json['protein'] as num).toInt(),
      carbs: (json['carbs'] as num).toInt(),
      fat: (json['fat'] as num).toInt(),
    );

Map<String, dynamic> _$CaloriesProtocolToJson(_CaloriesProtocol instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
    };
