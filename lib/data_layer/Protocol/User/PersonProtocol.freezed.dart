// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PersonProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonProtocol {

 int get personID; String get firstName; String? get lastName; DateTime? get dateOfBirth; String? get gender; String? get phoneNumber; String? get profileImageUrl; bool get isActive;
/// Create a copy of PersonProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonProtocolCopyWith<PersonProtocol> get copyWith => _$PersonProtocolCopyWithImpl<PersonProtocol>(this as PersonProtocol, _$identity);

  /// Serializes this PersonProtocol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonProtocol&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personID,firstName,lastName,dateOfBirth,gender,phoneNumber,profileImageUrl,isActive);

@override
String toString() {
  return 'PersonProtocol(personID: $personID, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, gender: $gender, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $PersonProtocolCopyWith<$Res>  {
  factory $PersonProtocolCopyWith(PersonProtocol value, $Res Function(PersonProtocol) _then) = _$PersonProtocolCopyWithImpl;
@useResult
$Res call({
 int personID, String firstName, String? lastName, DateTime? dateOfBirth, String? gender, String? phoneNumber, String? profileImageUrl, bool isActive
});




}
/// @nodoc
class _$PersonProtocolCopyWithImpl<$Res>
    implements $PersonProtocolCopyWith<$Res> {
  _$PersonProtocolCopyWithImpl(this._self, this._then);

  final PersonProtocol _self;
  final $Res Function(PersonProtocol) _then;

/// Create a copy of PersonProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? personID = null,Object? firstName = null,Object? lastName = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? phoneNumber = freezed,Object? profileImageUrl = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonProtocol].
extension PersonProtocolPatterns on PersonProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonProtocol value)  $default,){
final _that = this;
switch (_that) {
case _PersonProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _PersonProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int personID,  String firstName,  String? lastName,  DateTime? dateOfBirth,  String? gender,  String? phoneNumber,  String? profileImageUrl,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonProtocol() when $default != null:
return $default(_that.personID,_that.firstName,_that.lastName,_that.dateOfBirth,_that.gender,_that.phoneNumber,_that.profileImageUrl,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int personID,  String firstName,  String? lastName,  DateTime? dateOfBirth,  String? gender,  String? phoneNumber,  String? profileImageUrl,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _PersonProtocol():
return $default(_that.personID,_that.firstName,_that.lastName,_that.dateOfBirth,_that.gender,_that.phoneNumber,_that.profileImageUrl,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int personID,  String firstName,  String? lastName,  DateTime? dateOfBirth,  String? gender,  String? phoneNumber,  String? profileImageUrl,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _PersonProtocol() when $default != null:
return $default(_that.personID,_that.firstName,_that.lastName,_that.dateOfBirth,_that.gender,_that.phoneNumber,_that.profileImageUrl,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonProtocol implements PersonProtocol {
  const _PersonProtocol({required this.personID, required this.firstName, this.lastName, this.dateOfBirth, this.gender, this.phoneNumber, this.profileImageUrl, this.isActive = true});
  factory _PersonProtocol.fromJson(Map<String, dynamic> json) => _$PersonProtocolFromJson(json);

@override final  int personID;
@override final  String firstName;
@override final  String? lastName;
@override final  DateTime? dateOfBirth;
@override final  String? gender;
@override final  String? phoneNumber;
@override final  String? profileImageUrl;
@override@JsonKey() final  bool isActive;

/// Create a copy of PersonProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonProtocolCopyWith<_PersonProtocol> get copyWith => __$PersonProtocolCopyWithImpl<_PersonProtocol>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonProtocolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonProtocol&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personID,firstName,lastName,dateOfBirth,gender,phoneNumber,profileImageUrl,isActive);

@override
String toString() {
  return 'PersonProtocol(personID: $personID, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, gender: $gender, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$PersonProtocolCopyWith<$Res> implements $PersonProtocolCopyWith<$Res> {
  factory _$PersonProtocolCopyWith(_PersonProtocol value, $Res Function(_PersonProtocol) _then) = __$PersonProtocolCopyWithImpl;
@override @useResult
$Res call({
 int personID, String firstName, String? lastName, DateTime? dateOfBirth, String? gender, String? phoneNumber, String? profileImageUrl, bool isActive
});




}
/// @nodoc
class __$PersonProtocolCopyWithImpl<$Res>
    implements _$PersonProtocolCopyWith<$Res> {
  __$PersonProtocolCopyWithImpl(this._self, this._then);

  final _PersonProtocol _self;
  final $Res Function(_PersonProtocol) _then;

/// Create a copy of PersonProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? personID = null,Object? firstName = null,Object? lastName = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? phoneNumber = freezed,Object? profileImageUrl = freezed,Object? isActive = null,}) {
  return _then(_PersonProtocol(
personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
