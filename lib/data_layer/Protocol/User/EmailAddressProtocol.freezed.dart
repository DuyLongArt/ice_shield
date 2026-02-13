// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'EmailAddressProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmailAddressProtocol {

 int get emailAddressID; int get personID; String get emailAddress; String get emailType; bool get isPrimary; EmailStatus get status; DateTime? get verifiedAt;
/// Create a copy of EmailAddressProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailAddressProtocolCopyWith<EmailAddressProtocol> get copyWith => _$EmailAddressProtocolCopyWithImpl<EmailAddressProtocol>(this as EmailAddressProtocol, _$identity);

  /// Serializes this EmailAddressProtocol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAddressProtocol&&(identical(other.emailAddressID, emailAddressID) || other.emailAddressID == emailAddressID)&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress)&&(identical(other.emailType, emailType) || other.emailType == emailType)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.status, status) || other.status == status)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emailAddressID,personID,emailAddress,emailType,isPrimary,status,verifiedAt);

@override
String toString() {
  return 'EmailAddressProtocol(emailAddressID: $emailAddressID, personID: $personID, emailAddress: $emailAddress, emailType: $emailType, isPrimary: $isPrimary, status: $status, verifiedAt: $verifiedAt)';
}


}

/// @nodoc
abstract mixin class $EmailAddressProtocolCopyWith<$Res>  {
  factory $EmailAddressProtocolCopyWith(EmailAddressProtocol value, $Res Function(EmailAddressProtocol) _then) = _$EmailAddressProtocolCopyWithImpl;
@useResult
$Res call({
 int emailAddressID, int personID, String emailAddress, String emailType, bool isPrimary, EmailStatus status, DateTime? verifiedAt
});




}
/// @nodoc
class _$EmailAddressProtocolCopyWithImpl<$Res>
    implements $EmailAddressProtocolCopyWith<$Res> {
  _$EmailAddressProtocolCopyWithImpl(this._self, this._then);

  final EmailAddressProtocol _self;
  final $Res Function(EmailAddressProtocol) _then;

/// Create a copy of EmailAddressProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? emailAddressID = null,Object? personID = null,Object? emailAddress = null,Object? emailType = null,Object? isPrimary = null,Object? status = null,Object? verifiedAt = freezed,}) {
  return _then(_self.copyWith(
emailAddressID: null == emailAddressID ? _self.emailAddressID : emailAddressID // ignore: cast_nullable_to_non_nullable
as int,personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as String,emailType: null == emailType ? _self.emailType : emailType // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EmailStatus,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailAddressProtocol].
extension EmailAddressProtocolPatterns on EmailAddressProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailAddressProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailAddressProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailAddressProtocol value)  $default,){
final _that = this;
switch (_that) {
case _EmailAddressProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailAddressProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _EmailAddressProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int emailAddressID,  int personID,  String emailAddress,  String emailType,  bool isPrimary,  EmailStatus status,  DateTime? verifiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailAddressProtocol() when $default != null:
return $default(_that.emailAddressID,_that.personID,_that.emailAddress,_that.emailType,_that.isPrimary,_that.status,_that.verifiedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int emailAddressID,  int personID,  String emailAddress,  String emailType,  bool isPrimary,  EmailStatus status,  DateTime? verifiedAt)  $default,) {final _that = this;
switch (_that) {
case _EmailAddressProtocol():
return $default(_that.emailAddressID,_that.personID,_that.emailAddress,_that.emailType,_that.isPrimary,_that.status,_that.verifiedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int emailAddressID,  int personID,  String emailAddress,  String emailType,  bool isPrimary,  EmailStatus status,  DateTime? verifiedAt)?  $default,) {final _that = this;
switch (_that) {
case _EmailAddressProtocol() when $default != null:
return $default(_that.emailAddressID,_that.personID,_that.emailAddress,_that.emailType,_that.isPrimary,_that.status,_that.verifiedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailAddressProtocol implements EmailAddressProtocol {
  const _EmailAddressProtocol({required this.emailAddressID, required this.personID, required this.emailAddress, this.emailType = 'personal', this.isPrimary = true, this.status = EmailStatus.pending, this.verifiedAt});
  factory _EmailAddressProtocol.fromJson(Map<String, dynamic> json) => _$EmailAddressProtocolFromJson(json);

@override final  int emailAddressID;
@override final  int personID;
@override final  String emailAddress;
@override@JsonKey() final  String emailType;
@override@JsonKey() final  bool isPrimary;
@override@JsonKey() final  EmailStatus status;
@override final  DateTime? verifiedAt;

/// Create a copy of EmailAddressProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailAddressProtocolCopyWith<_EmailAddressProtocol> get copyWith => __$EmailAddressProtocolCopyWithImpl<_EmailAddressProtocol>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailAddressProtocolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailAddressProtocol&&(identical(other.emailAddressID, emailAddressID) || other.emailAddressID == emailAddressID)&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress)&&(identical(other.emailType, emailType) || other.emailType == emailType)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.status, status) || other.status == status)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emailAddressID,personID,emailAddress,emailType,isPrimary,status,verifiedAt);

@override
String toString() {
  return 'EmailAddressProtocol(emailAddressID: $emailAddressID, personID: $personID, emailAddress: $emailAddress, emailType: $emailType, isPrimary: $isPrimary, status: $status, verifiedAt: $verifiedAt)';
}


}

/// @nodoc
abstract mixin class _$EmailAddressProtocolCopyWith<$Res> implements $EmailAddressProtocolCopyWith<$Res> {
  factory _$EmailAddressProtocolCopyWith(_EmailAddressProtocol value, $Res Function(_EmailAddressProtocol) _then) = __$EmailAddressProtocolCopyWithImpl;
@override @useResult
$Res call({
 int emailAddressID, int personID, String emailAddress, String emailType, bool isPrimary, EmailStatus status, DateTime? verifiedAt
});




}
/// @nodoc
class __$EmailAddressProtocolCopyWithImpl<$Res>
    implements _$EmailAddressProtocolCopyWith<$Res> {
  __$EmailAddressProtocolCopyWithImpl(this._self, this._then);

  final _EmailAddressProtocol _self;
  final $Res Function(_EmailAddressProtocol) _then;

/// Create a copy of EmailAddressProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? emailAddressID = null,Object? personID = null,Object? emailAddress = null,Object? emailType = null,Object? isPrimary = null,Object? status = null,Object? verifiedAt = freezed,}) {
  return _then(_EmailAddressProtocol(
emailAddressID: null == emailAddressID ? _self.emailAddressID : emailAddressID // ignore: cast_nullable_to_non_nullable
as int,personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as String,emailType: null == emailType ? _self.emailType : emailType // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EmailStatus,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
