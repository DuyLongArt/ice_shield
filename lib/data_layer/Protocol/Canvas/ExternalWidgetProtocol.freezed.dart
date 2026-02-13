// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ExternalWidgetProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExternalWidgetProtocol {

 String get name; String get protocol; String get host; String get url; String? get alias; String? get imageUrl; String? get dateAdded;
/// Create a copy of ExternalWidgetProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExternalWidgetProtocolCopyWith<ExternalWidgetProtocol> get copyWith => _$ExternalWidgetProtocolCopyWithImpl<ExternalWidgetProtocol>(this as ExternalWidgetProtocol, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExternalWidgetProtocol&&(identical(other.name, name) || other.name == name)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.host, host) || other.host == host)&&(identical(other.url, url) || other.url == url)&&(identical(other.alias, alias) || other.alias == alias)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded));
}


@override
int get hashCode => Object.hash(runtimeType,name,protocol,host,url,alias,imageUrl,dateAdded);

@override
String toString() {
  return 'ExternalWidgetProtocol(name: $name, protocol: $protocol, host: $host, url: $url, alias: $alias, imageUrl: $imageUrl, dateAdded: $dateAdded)';
}


}

/// @nodoc
abstract mixin class $ExternalWidgetProtocolCopyWith<$Res>  {
  factory $ExternalWidgetProtocolCopyWith(ExternalWidgetProtocol value, $Res Function(ExternalWidgetProtocol) _then) = _$ExternalWidgetProtocolCopyWithImpl;
@useResult
$Res call({
 String name, String protocol, String host, String url, String? alias, String? imageUrl, String? dateAdded
});




}
/// @nodoc
class _$ExternalWidgetProtocolCopyWithImpl<$Res>
    implements $ExternalWidgetProtocolCopyWith<$Res> {
  _$ExternalWidgetProtocolCopyWithImpl(this._self, this._then);

  final ExternalWidgetProtocol _self;
  final $Res Function(ExternalWidgetProtocol) _then;

/// Create a copy of ExternalWidgetProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? protocol = null,Object? host = null,Object? url = null,Object? alias = freezed,Object? imageUrl = freezed,Object? dateAdded = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as String,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,alias: freezed == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExternalWidgetProtocol].
extension ExternalWidgetProtocolPatterns on ExternalWidgetProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExternalWidgetProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExternalWidgetProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExternalWidgetProtocol value)  $default,){
final _that = this;
switch (_that) {
case _ExternalWidgetProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExternalWidgetProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _ExternalWidgetProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String protocol,  String host,  String url,  String? alias,  String? imageUrl,  String? dateAdded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExternalWidgetProtocol() when $default != null:
return $default(_that.name,_that.protocol,_that.host,_that.url,_that.alias,_that.imageUrl,_that.dateAdded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String protocol,  String host,  String url,  String? alias,  String? imageUrl,  String? dateAdded)  $default,) {final _that = this;
switch (_that) {
case _ExternalWidgetProtocol():
return $default(_that.name,_that.protocol,_that.host,_that.url,_that.alias,_that.imageUrl,_that.dateAdded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String protocol,  String host,  String url,  String? alias,  String? imageUrl,  String? dateAdded)?  $default,) {final _that = this;
switch (_that) {
case _ExternalWidgetProtocol() when $default != null:
return $default(_that.name,_that.protocol,_that.host,_that.url,_that.alias,_that.imageUrl,_that.dateAdded);case _:
  return null;

}
}

}

/// @nodoc


class _ExternalWidgetProtocol implements ExternalWidgetProtocol {
  const _ExternalWidgetProtocol({required this.name, required this.protocol, required this.host, required this.url, this.alias, this.imageUrl, this.dateAdded});
  

@override final  String name;
@override final  String protocol;
@override final  String host;
@override final  String url;
@override final  String? alias;
@override final  String? imageUrl;
@override final  String? dateAdded;

/// Create a copy of ExternalWidgetProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExternalWidgetProtocolCopyWith<_ExternalWidgetProtocol> get copyWith => __$ExternalWidgetProtocolCopyWithImpl<_ExternalWidgetProtocol>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExternalWidgetProtocol&&(identical(other.name, name) || other.name == name)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.host, host) || other.host == host)&&(identical(other.url, url) || other.url == url)&&(identical(other.alias, alias) || other.alias == alias)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded));
}


@override
int get hashCode => Object.hash(runtimeType,name,protocol,host,url,alias,imageUrl,dateAdded);

@override
String toString() {
  return 'ExternalWidgetProtocol(name: $name, protocol: $protocol, host: $host, url: $url, alias: $alias, imageUrl: $imageUrl, dateAdded: $dateAdded)';
}


}

/// @nodoc
abstract mixin class _$ExternalWidgetProtocolCopyWith<$Res> implements $ExternalWidgetProtocolCopyWith<$Res> {
  factory _$ExternalWidgetProtocolCopyWith(_ExternalWidgetProtocol value, $Res Function(_ExternalWidgetProtocol) _then) = __$ExternalWidgetProtocolCopyWithImpl;
@override @useResult
$Res call({
 String name, String protocol, String host, String url, String? alias, String? imageUrl, String? dateAdded
});




}
/// @nodoc
class __$ExternalWidgetProtocolCopyWithImpl<$Res>
    implements _$ExternalWidgetProtocolCopyWith<$Res> {
  __$ExternalWidgetProtocolCopyWithImpl(this._self, this._then);

  final _ExternalWidgetProtocol _self;
  final $Res Function(_ExternalWidgetProtocol) _then;

/// Create a copy of ExternalWidgetProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? protocol = null,Object? host = null,Object? url = null,Object? alias = freezed,Object? imageUrl = freezed,Object? dateAdded = freezed,}) {
  return _then(_ExternalWidgetProtocol(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as String,host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,alias: freezed == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
