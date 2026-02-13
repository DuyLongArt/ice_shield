// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'GpsLocation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GpsLocation {

 double get latitude; double get longitude; DateTime get timestamp; double get altitude; double get speed; double get heading; double get accuracy; double get speedAccuracy; double get headingAccuracy;
/// Create a copy of GpsLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GpsLocationCopyWith<GpsLocation> get copyWith => _$GpsLocationCopyWithImpl<GpsLocation>(this as GpsLocation, _$identity);

  /// Serializes this GpsLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpsLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.speedAccuracy, speedAccuracy) || other.speedAccuracy == speedAccuracy)&&(identical(other.headingAccuracy, headingAccuracy) || other.headingAccuracy == headingAccuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,timestamp,altitude,speed,heading,accuracy,speedAccuracy,headingAccuracy);

@override
String toString() {
  return 'GpsLocation(latitude: $latitude, longitude: $longitude, timestamp: $timestamp, altitude: $altitude, speed: $speed, heading: $heading, accuracy: $accuracy, speedAccuracy: $speedAccuracy, headingAccuracy: $headingAccuracy)';
}


}

/// @nodoc
abstract mixin class $GpsLocationCopyWith<$Res>  {
  factory $GpsLocationCopyWith(GpsLocation value, $Res Function(GpsLocation) _then) = _$GpsLocationCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, DateTime timestamp, double altitude, double speed, double heading, double accuracy, double speedAccuracy, double headingAccuracy
});




}
/// @nodoc
class _$GpsLocationCopyWithImpl<$Res>
    implements $GpsLocationCopyWith<$Res> {
  _$GpsLocationCopyWithImpl(this._self, this._then);

  final GpsLocation _self;
  final $Res Function(GpsLocation) _then;

/// Create a copy of GpsLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? timestamp = null,Object? altitude = null,Object? speed = null,Object? heading = null,Object? accuracy = null,Object? speedAccuracy = null,Object? headingAccuracy = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,altitude: null == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,speedAccuracy: null == speedAccuracy ? _self.speedAccuracy : speedAccuracy // ignore: cast_nullable_to_non_nullable
as double,headingAccuracy: null == headingAccuracy ? _self.headingAccuracy : headingAccuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GpsLocation].
extension GpsLocationPatterns on GpsLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GpsLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GpsLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GpsLocation value)  $default,){
final _that = this;
switch (_that) {
case _GpsLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GpsLocation value)?  $default,){
final _that = this;
switch (_that) {
case _GpsLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  DateTime timestamp,  double altitude,  double speed,  double heading,  double accuracy,  double speedAccuracy,  double headingAccuracy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GpsLocation() when $default != null:
return $default(_that.latitude,_that.longitude,_that.timestamp,_that.altitude,_that.speed,_that.heading,_that.accuracy,_that.speedAccuracy,_that.headingAccuracy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  DateTime timestamp,  double altitude,  double speed,  double heading,  double accuracy,  double speedAccuracy,  double headingAccuracy)  $default,) {final _that = this;
switch (_that) {
case _GpsLocation():
return $default(_that.latitude,_that.longitude,_that.timestamp,_that.altitude,_that.speed,_that.heading,_that.accuracy,_that.speedAccuracy,_that.headingAccuracy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  DateTime timestamp,  double altitude,  double speed,  double heading,  double accuracy,  double speedAccuracy,  double headingAccuracy)?  $default,) {final _that = this;
switch (_that) {
case _GpsLocation() when $default != null:
return $default(_that.latitude,_that.longitude,_that.timestamp,_that.altitude,_that.speed,_that.heading,_that.accuracy,_that.speedAccuracy,_that.headingAccuracy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GpsLocation implements GpsLocation {
  const _GpsLocation({required this.latitude, required this.longitude, required this.timestamp, this.altitude = 0.0, this.speed = 0.0, this.heading = 0.0, this.accuracy = 0.0, this.speedAccuracy = 0.0, this.headingAccuracy = 0.0});
  factory _GpsLocation.fromJson(Map<String, dynamic> json) => _$GpsLocationFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override final  DateTime timestamp;
@override@JsonKey() final  double altitude;
@override@JsonKey() final  double speed;
@override@JsonKey() final  double heading;
@override@JsonKey() final  double accuracy;
@override@JsonKey() final  double speedAccuracy;
@override@JsonKey() final  double headingAccuracy;

/// Create a copy of GpsLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GpsLocationCopyWith<_GpsLocation> get copyWith => __$GpsLocationCopyWithImpl<_GpsLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GpsLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GpsLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.speedAccuracy, speedAccuracy) || other.speedAccuracy == speedAccuracy)&&(identical(other.headingAccuracy, headingAccuracy) || other.headingAccuracy == headingAccuracy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,timestamp,altitude,speed,heading,accuracy,speedAccuracy,headingAccuracy);

@override
String toString() {
  return 'GpsLocation(latitude: $latitude, longitude: $longitude, timestamp: $timestamp, altitude: $altitude, speed: $speed, heading: $heading, accuracy: $accuracy, speedAccuracy: $speedAccuracy, headingAccuracy: $headingAccuracy)';
}


}

/// @nodoc
abstract mixin class _$GpsLocationCopyWith<$Res> implements $GpsLocationCopyWith<$Res> {
  factory _$GpsLocationCopyWith(_GpsLocation value, $Res Function(_GpsLocation) _then) = __$GpsLocationCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, DateTime timestamp, double altitude, double speed, double heading, double accuracy, double speedAccuracy, double headingAccuracy
});




}
/// @nodoc
class __$GpsLocationCopyWithImpl<$Res>
    implements _$GpsLocationCopyWith<$Res> {
  __$GpsLocationCopyWithImpl(this._self, this._then);

  final _GpsLocation _self;
  final $Res Function(_GpsLocation) _then;

/// Create a copy of GpsLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? timestamp = null,Object? altitude = null,Object? speed = null,Object? heading = null,Object? accuracy = null,Object? speedAccuracy = null,Object? headingAccuracy = null,}) {
  return _then(_GpsLocation(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,altitude: null == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,speedAccuracy: null == speedAccuracy ? _self.speedAccuracy : speedAccuracy // ignore: cast_nullable_to_non_nullable
as double,headingAccuracy: null == headingAccuracy ? _self.headingAccuracy : headingAccuracy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
