// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'BluetoothDeviceInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BluetoothDeviceInfo {

 String get id; String get name; bool get isConnected; int get rssi;// Signal strength
 String get deviceType;
/// Create a copy of BluetoothDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BluetoothDeviceInfoCopyWith<BluetoothDeviceInfo> get copyWith => _$BluetoothDeviceInfoCopyWithImpl<BluetoothDeviceInfo>(this as BluetoothDeviceInfo, _$identity);

  /// Serializes this BluetoothDeviceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BluetoothDeviceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.rssi, rssi) || other.rssi == rssi)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isConnected,rssi,deviceType);

@override
String toString() {
  return 'BluetoothDeviceInfo(id: $id, name: $name, isConnected: $isConnected, rssi: $rssi, deviceType: $deviceType)';
}


}

/// @nodoc
abstract mixin class $BluetoothDeviceInfoCopyWith<$Res>  {
  factory $BluetoothDeviceInfoCopyWith(BluetoothDeviceInfo value, $Res Function(BluetoothDeviceInfo) _then) = _$BluetoothDeviceInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool isConnected, int rssi, String deviceType
});




}
/// @nodoc
class _$BluetoothDeviceInfoCopyWithImpl<$Res>
    implements $BluetoothDeviceInfoCopyWith<$Res> {
  _$BluetoothDeviceInfoCopyWithImpl(this._self, this._then);

  final BluetoothDeviceInfo _self;
  final $Res Function(BluetoothDeviceInfo) _then;

/// Create a copy of BluetoothDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isConnected = null,Object? rssi = null,Object? deviceType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,rssi: null == rssi ? _self.rssi : rssi // ignore: cast_nullable_to_non_nullable
as int,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BluetoothDeviceInfo].
extension BluetoothDeviceInfoPatterns on BluetoothDeviceInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BluetoothDeviceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BluetoothDeviceInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BluetoothDeviceInfo value)  $default,){
final _that = this;
switch (_that) {
case _BluetoothDeviceInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BluetoothDeviceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _BluetoothDeviceInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool isConnected,  int rssi,  String deviceType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BluetoothDeviceInfo() when $default != null:
return $default(_that.id,_that.name,_that.isConnected,_that.rssi,_that.deviceType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool isConnected,  int rssi,  String deviceType)  $default,) {final _that = this;
switch (_that) {
case _BluetoothDeviceInfo():
return $default(_that.id,_that.name,_that.isConnected,_that.rssi,_that.deviceType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool isConnected,  int rssi,  String deviceType)?  $default,) {final _that = this;
switch (_that) {
case _BluetoothDeviceInfo() when $default != null:
return $default(_that.id,_that.name,_that.isConnected,_that.rssi,_that.deviceType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BluetoothDeviceInfo implements BluetoothDeviceInfo {
  const _BluetoothDeviceInfo({required this.id, required this.name, this.isConnected = false, this.rssi = 0, this.deviceType = 'Unknown'});
  factory _BluetoothDeviceInfo.fromJson(Map<String, dynamic> json) => _$BluetoothDeviceInfoFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  bool isConnected;
@override@JsonKey() final  int rssi;
// Signal strength
@override@JsonKey() final  String deviceType;

/// Create a copy of BluetoothDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BluetoothDeviceInfoCopyWith<_BluetoothDeviceInfo> get copyWith => __$BluetoothDeviceInfoCopyWithImpl<_BluetoothDeviceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BluetoothDeviceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BluetoothDeviceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.rssi, rssi) || other.rssi == rssi)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isConnected,rssi,deviceType);

@override
String toString() {
  return 'BluetoothDeviceInfo(id: $id, name: $name, isConnected: $isConnected, rssi: $rssi, deviceType: $deviceType)';
}


}

/// @nodoc
abstract mixin class _$BluetoothDeviceInfoCopyWith<$Res> implements $BluetoothDeviceInfoCopyWith<$Res> {
  factory _$BluetoothDeviceInfoCopyWith(_BluetoothDeviceInfo value, $Res Function(_BluetoothDeviceInfo) _then) = __$BluetoothDeviceInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool isConnected, int rssi, String deviceType
});




}
/// @nodoc
class __$BluetoothDeviceInfoCopyWithImpl<$Res>
    implements _$BluetoothDeviceInfoCopyWith<$Res> {
  __$BluetoothDeviceInfoCopyWithImpl(this._self, this._then);

  final _BluetoothDeviceInfo _self;
  final $Res Function(_BluetoothDeviceInfo) _then;

/// Create a copy of BluetoothDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isConnected = null,Object? rssi = null,Object? deviceType = null,}) {
  return _then(_BluetoothDeviceInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,rssi: null == rssi ? _self.rssi : rssi // ignore: cast_nullable_to_non_nullable
as int,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
