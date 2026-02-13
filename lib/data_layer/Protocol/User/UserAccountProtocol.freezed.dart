// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'UserAccountProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserAccountProtocol {

 int get accountID; int get personID; String get username; String? get primaryEmail; String get role; bool get isLocked; DateTime? get lastLoginAt;
/// Create a copy of UserAccountProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAccountProtocolCopyWith<UserAccountProtocol> get copyWith => _$UserAccountProtocolCopyWithImpl<UserAccountProtocol>(this as UserAccountProtocol, _$identity);

  /// Serializes this UserAccountProtocol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAccountProtocol&&(identical(other.accountID, accountID) || other.accountID == accountID)&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.username, username) || other.username == username)&&(identical(other.primaryEmail, primaryEmail) || other.primaryEmail == primaryEmail)&&(identical(other.role, role) || other.role == role)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountID,personID,username,primaryEmail,role,isLocked,lastLoginAt);

@override
String toString() {
  return 'UserAccountProtocol(accountID: $accountID, personID: $personID, username: $username, primaryEmail: $primaryEmail, role: $role, isLocked: $isLocked, lastLoginAt: $lastLoginAt)';
}


}

/// @nodoc
abstract mixin class $UserAccountProtocolCopyWith<$Res>  {
  factory $UserAccountProtocolCopyWith(UserAccountProtocol value, $Res Function(UserAccountProtocol) _then) = _$UserAccountProtocolCopyWithImpl;
@useResult
$Res call({
 int accountID, int personID, String username, String? primaryEmail, String role, bool isLocked, DateTime? lastLoginAt
});




}
/// @nodoc
class _$UserAccountProtocolCopyWithImpl<$Res>
    implements $UserAccountProtocolCopyWith<$Res> {
  _$UserAccountProtocolCopyWithImpl(this._self, this._then);

  final UserAccountProtocol _self;
  final $Res Function(UserAccountProtocol) _then;

/// Create a copy of UserAccountProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountID = null,Object? personID = null,Object? username = null,Object? primaryEmail = freezed,Object? role = null,Object? isLocked = null,Object? lastLoginAt = freezed,}) {
  return _then(_self.copyWith(
accountID: null == accountID ? _self.accountID : accountID // ignore: cast_nullable_to_non_nullable
as int,personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,primaryEmail: freezed == primaryEmail ? _self.primaryEmail : primaryEmail // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAccountProtocol].
extension UserAccountProtocolPatterns on UserAccountProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAccountProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAccountProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAccountProtocol value)  $default,){
final _that = this;
switch (_that) {
case _UserAccountProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAccountProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _UserAccountProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int accountID,  int personID,  String username,  String? primaryEmail,  String role,  bool isLocked,  DateTime? lastLoginAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAccountProtocol() when $default != null:
return $default(_that.accountID,_that.personID,_that.username,_that.primaryEmail,_that.role,_that.isLocked,_that.lastLoginAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int accountID,  int personID,  String username,  String? primaryEmail,  String role,  bool isLocked,  DateTime? lastLoginAt)  $default,) {final _that = this;
switch (_that) {
case _UserAccountProtocol():
return $default(_that.accountID,_that.personID,_that.username,_that.primaryEmail,_that.role,_that.isLocked,_that.lastLoginAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int accountID,  int personID,  String username,  String? primaryEmail,  String role,  bool isLocked,  DateTime? lastLoginAt)?  $default,) {final _that = this;
switch (_that) {
case _UserAccountProtocol() when $default != null:
return $default(_that.accountID,_that.personID,_that.username,_that.primaryEmail,_that.role,_that.isLocked,_that.lastLoginAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserAccountProtocol extends UserAccountProtocol {
  const _UserAccountProtocol({required this.accountID, required this.personID, required this.username, this.primaryEmail, this.role = 'user', this.isLocked = false, this.lastLoginAt}): super._();
  factory _UserAccountProtocol.fromJson(Map<String, dynamic> json) => _$UserAccountProtocolFromJson(json);

@override final  int accountID;
@override final  int personID;
@override final  String username;
@override final  String? primaryEmail;
@override@JsonKey() final  String role;
@override@JsonKey() final  bool isLocked;
@override final  DateTime? lastLoginAt;

/// Create a copy of UserAccountProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAccountProtocolCopyWith<_UserAccountProtocol> get copyWith => __$UserAccountProtocolCopyWithImpl<_UserAccountProtocol>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAccountProtocolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAccountProtocol&&(identical(other.accountID, accountID) || other.accountID == accountID)&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.username, username) || other.username == username)&&(identical(other.primaryEmail, primaryEmail) || other.primaryEmail == primaryEmail)&&(identical(other.role, role) || other.role == role)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountID,personID,username,primaryEmail,role,isLocked,lastLoginAt);

@override
String toString() {
  return 'UserAccountProtocol(accountID: $accountID, personID: $personID, username: $username, primaryEmail: $primaryEmail, role: $role, isLocked: $isLocked, lastLoginAt: $lastLoginAt)';
}


}

/// @nodoc
abstract mixin class _$UserAccountProtocolCopyWith<$Res> implements $UserAccountProtocolCopyWith<$Res> {
  factory _$UserAccountProtocolCopyWith(_UserAccountProtocol value, $Res Function(_UserAccountProtocol) _then) = __$UserAccountProtocolCopyWithImpl;
@override @useResult
$Res call({
 int accountID, int personID, String username, String? primaryEmail, String role, bool isLocked, DateTime? lastLoginAt
});




}
/// @nodoc
class __$UserAccountProtocolCopyWithImpl<$Res>
    implements _$UserAccountProtocolCopyWith<$Res> {
  __$UserAccountProtocolCopyWithImpl(this._self, this._then);

  final _UserAccountProtocol _self;
  final $Res Function(_UserAccountProtocol) _then;

/// Create a copy of UserAccountProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountID = null,Object? personID = null,Object? username = null,Object? primaryEmail = freezed,Object? role = null,Object? isLocked = null,Object? lastLoginAt = freezed,}) {
  return _then(_UserAccountProtocol(
accountID: null == accountID ? _self.accountID : accountID // ignore: cast_nullable_to_non_nullable
as int,personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,primaryEmail: freezed == primaryEmail ? _self.primaryEmail : primaryEmail // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
