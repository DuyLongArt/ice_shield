// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'AuthenticationProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthenticationProtocol {

 String get username; String get password; String get jwt;
/// Create a copy of AuthenticationProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationProtocolCopyWith<AuthenticationProtocol> get copyWith => _$AuthenticationProtocolCopyWithImpl<AuthenticationProtocol>(this as AuthenticationProtocol, _$identity);

  /// Serializes this AuthenticationProtocol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationProtocol&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.jwt, jwt) || other.jwt == jwt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,password,jwt);

@override
String toString() {
  return 'AuthenticationProtocol(username: $username, password: $password, jwt: $jwt)';
}


}

/// @nodoc
abstract mixin class $AuthenticationProtocolCopyWith<$Res>  {
  factory $AuthenticationProtocolCopyWith(AuthenticationProtocol value, $Res Function(AuthenticationProtocol) _then) = _$AuthenticationProtocolCopyWithImpl;
@useResult
$Res call({
 String username, String password, String jwt
});




}
/// @nodoc
class _$AuthenticationProtocolCopyWithImpl<$Res>
    implements $AuthenticationProtocolCopyWith<$Res> {
  _$AuthenticationProtocolCopyWithImpl(this._self, this._then);

  final AuthenticationProtocol _self;
  final $Res Function(AuthenticationProtocol) _then;

/// Create a copy of AuthenticationProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? password = null,Object? jwt = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,jwt: null == jwt ? _self.jwt : jwt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthenticationProtocol].
extension AuthenticationProtocolPatterns on AuthenticationProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthenticationProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthenticationProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthenticationProtocol value)  $default,){
final _that = this;
switch (_that) {
case _AuthenticationProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthenticationProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _AuthenticationProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String password,  String jwt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthenticationProtocol() when $default != null:
return $default(_that.username,_that.password,_that.jwt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String password,  String jwt)  $default,) {final _that = this;
switch (_that) {
case _AuthenticationProtocol():
return $default(_that.username,_that.password,_that.jwt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String password,  String jwt)?  $default,) {final _that = this;
switch (_that) {
case _AuthenticationProtocol() when $default != null:
return $default(_that.username,_that.password,_that.jwt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthenticationProtocol implements AuthenticationProtocol {
  const _AuthenticationProtocol({required this.username, required this.password, required this.jwt});
  factory _AuthenticationProtocol.fromJson(Map<String, dynamic> json) => _$AuthenticationProtocolFromJson(json);

@override final  String username;
@override final  String password;
@override final  String jwt;

/// Create a copy of AuthenticationProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticationProtocolCopyWith<_AuthenticationProtocol> get copyWith => __$AuthenticationProtocolCopyWithImpl<_AuthenticationProtocol>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthenticationProtocolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthenticationProtocol&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.jwt, jwt) || other.jwt == jwt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,password,jwt);

@override
String toString() {
  return 'AuthenticationProtocol(username: $username, password: $password, jwt: $jwt)';
}


}

/// @nodoc
abstract mixin class _$AuthenticationProtocolCopyWith<$Res> implements $AuthenticationProtocolCopyWith<$Res> {
  factory _$AuthenticationProtocolCopyWith(_AuthenticationProtocol value, $Res Function(_AuthenticationProtocol) _then) = __$AuthenticationProtocolCopyWithImpl;
@override @useResult
$Res call({
 String username, String password, String jwt
});




}
/// @nodoc
class __$AuthenticationProtocolCopyWithImpl<$Res>
    implements _$AuthenticationProtocolCopyWith<$Res> {
  __$AuthenticationProtocolCopyWithImpl(this._self, this._then);

  final _AuthenticationProtocol _self;
  final $Res Function(_AuthenticationProtocol) _then;

/// Create a copy of AuthenticationProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,Object? jwt = null,}) {
  return _then(_AuthenticationProtocol(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,jwt: null == jwt ? _self.jwt : jwt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
