// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BluetoothDeviceInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BluetoothDeviceInfo _$BluetoothDeviceInfoFromJson(Map<String, dynamic> json) =>
    _BluetoothDeviceInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      isConnected: json['isConnected'] as bool? ?? false,
      rssi: (json['rssi'] as num?)?.toInt() ?? 0,
      deviceType: json['deviceType'] as String? ?? 'Unknown',
    );

Map<String, dynamic> _$BluetoothDeviceInfoToJson(
  _BluetoothDeviceInfo instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'isConnected': instance.isConnected,
  'rssi': instance.rssi,
  'deviceType': instance.deviceType,
};
