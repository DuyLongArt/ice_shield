// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ProfileProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileProtocol {

 int get profileID; int get personID; String? get bio; String? get occupation; String? get educationLevel; String? get location; String? get websiteUrl; String? get linkedinUrl; String? get githubUrl;
/// Create a copy of ProfileProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileProtocolCopyWith<ProfileProtocol> get copyWith => _$ProfileProtocolCopyWithImpl<ProfileProtocol>(this as ProfileProtocol, _$identity);

  /// Serializes this ProfileProtocol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileProtocol&&(identical(other.profileID, profileID) || other.profileID == profileID)&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.educationLevel, educationLevel) || other.educationLevel == educationLevel)&&(identical(other.location, location) || other.location == location)&&(identical(other.websiteUrl, websiteUrl) || other.websiteUrl == websiteUrl)&&(identical(other.linkedinUrl, linkedinUrl) || other.linkedinUrl == linkedinUrl)&&(identical(other.githubUrl, githubUrl) || other.githubUrl == githubUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileID,personID,bio,occupation,educationLevel,location,websiteUrl,linkedinUrl,githubUrl);

@override
String toString() {
  return 'ProfileProtocol(profileID: $profileID, personID: $personID, bio: $bio, occupation: $occupation, educationLevel: $educationLevel, location: $location, websiteUrl: $websiteUrl, linkedinUrl: $linkedinUrl, githubUrl: $githubUrl)';
}


}

/// @nodoc
abstract mixin class $ProfileProtocolCopyWith<$Res>  {
  factory $ProfileProtocolCopyWith(ProfileProtocol value, $Res Function(ProfileProtocol) _then) = _$ProfileProtocolCopyWithImpl;
@useResult
$Res call({
 int profileID, int personID, String? bio, String? occupation, String? educationLevel, String? location, String? websiteUrl, String? linkedinUrl, String? githubUrl
});




}
/// @nodoc
class _$ProfileProtocolCopyWithImpl<$Res>
    implements $ProfileProtocolCopyWith<$Res> {
  _$ProfileProtocolCopyWithImpl(this._self, this._then);

  final ProfileProtocol _self;
  final $Res Function(ProfileProtocol) _then;

/// Create a copy of ProfileProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileID = null,Object? personID = null,Object? bio = freezed,Object? occupation = freezed,Object? educationLevel = freezed,Object? location = freezed,Object? websiteUrl = freezed,Object? linkedinUrl = freezed,Object? githubUrl = freezed,}) {
  return _then(_self.copyWith(
profileID: null == profileID ? _self.profileID : profileID // ignore: cast_nullable_to_non_nullable
as int,personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,educationLevel: freezed == educationLevel ? _self.educationLevel : educationLevel // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,websiteUrl: freezed == websiteUrl ? _self.websiteUrl : websiteUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedinUrl: freezed == linkedinUrl ? _self.linkedinUrl : linkedinUrl // ignore: cast_nullable_to_non_nullable
as String?,githubUrl: freezed == githubUrl ? _self.githubUrl : githubUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileProtocol].
extension ProfileProtocolPatterns on ProfileProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileProtocol value)  $default,){
final _that = this;
switch (_that) {
case _ProfileProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int profileID,  int personID,  String? bio,  String? occupation,  String? educationLevel,  String? location,  String? websiteUrl,  String? linkedinUrl,  String? githubUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileProtocol() when $default != null:
return $default(_that.profileID,_that.personID,_that.bio,_that.occupation,_that.educationLevel,_that.location,_that.websiteUrl,_that.linkedinUrl,_that.githubUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int profileID,  int personID,  String? bio,  String? occupation,  String? educationLevel,  String? location,  String? websiteUrl,  String? linkedinUrl,  String? githubUrl)  $default,) {final _that = this;
switch (_that) {
case _ProfileProtocol():
return $default(_that.profileID,_that.personID,_that.bio,_that.occupation,_that.educationLevel,_that.location,_that.websiteUrl,_that.linkedinUrl,_that.githubUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int profileID,  int personID,  String? bio,  String? occupation,  String? educationLevel,  String? location,  String? websiteUrl,  String? linkedinUrl,  String? githubUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProfileProtocol() when $default != null:
return $default(_that.profileID,_that.personID,_that.bio,_that.occupation,_that.educationLevel,_that.location,_that.websiteUrl,_that.linkedinUrl,_that.githubUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileProtocol implements ProfileProtocol {
   _ProfileProtocol({required this.profileID, required this.personID, this.bio, this.occupation, this.educationLevel, this.location, this.websiteUrl, this.linkedinUrl, this.githubUrl});
  factory _ProfileProtocol.fromJson(Map<String, dynamic> json) => _$ProfileProtocolFromJson(json);

@override final  int profileID;
@override final  int personID;
@override final  String? bio;
@override final  String? occupation;
@override final  String? educationLevel;
@override final  String? location;
@override final  String? websiteUrl;
@override final  String? linkedinUrl;
@override final  String? githubUrl;

/// Create a copy of ProfileProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileProtocolCopyWith<_ProfileProtocol> get copyWith => __$ProfileProtocolCopyWithImpl<_ProfileProtocol>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileProtocolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileProtocol&&(identical(other.profileID, profileID) || other.profileID == profileID)&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.educationLevel, educationLevel) || other.educationLevel == educationLevel)&&(identical(other.location, location) || other.location == location)&&(identical(other.websiteUrl, websiteUrl) || other.websiteUrl == websiteUrl)&&(identical(other.linkedinUrl, linkedinUrl) || other.linkedinUrl == linkedinUrl)&&(identical(other.githubUrl, githubUrl) || other.githubUrl == githubUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileID,personID,bio,occupation,educationLevel,location,websiteUrl,linkedinUrl,githubUrl);

@override
String toString() {
  return 'ProfileProtocol(profileID: $profileID, personID: $personID, bio: $bio, occupation: $occupation, educationLevel: $educationLevel, location: $location, websiteUrl: $websiteUrl, linkedinUrl: $linkedinUrl, githubUrl: $githubUrl)';
}


}

/// @nodoc
abstract mixin class _$ProfileProtocolCopyWith<$Res> implements $ProfileProtocolCopyWith<$Res> {
  factory _$ProfileProtocolCopyWith(_ProfileProtocol value, $Res Function(_ProfileProtocol) _then) = __$ProfileProtocolCopyWithImpl;
@override @useResult
$Res call({
 int profileID, int personID, String? bio, String? occupation, String? educationLevel, String? location, String? websiteUrl, String? linkedinUrl, String? githubUrl
});




}
/// @nodoc
class __$ProfileProtocolCopyWithImpl<$Res>
    implements _$ProfileProtocolCopyWith<$Res> {
  __$ProfileProtocolCopyWithImpl(this._self, this._then);

  final _ProfileProtocol _self;
  final $Res Function(_ProfileProtocol) _then;

/// Create a copy of ProfileProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileID = null,Object? personID = null,Object? bio = freezed,Object? occupation = freezed,Object? educationLevel = freezed,Object? location = freezed,Object? websiteUrl = freezed,Object? linkedinUrl = freezed,Object? githubUrl = freezed,}) {
  return _then(_ProfileProtocol(
profileID: null == profileID ? _self.profileID : profileID // ignore: cast_nullable_to_non_nullable
as int,personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,educationLevel: freezed == educationLevel ? _self.educationLevel : educationLevel // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,websiteUrl: freezed == websiteUrl ? _self.websiteUrl : websiteUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedinUrl: freezed == linkedinUrl ? _self.linkedinUrl : linkedinUrl // ignore: cast_nullable_to_non_nullable
as String?,githubUrl: freezed == githubUrl ? _self.githubUrl : githubUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
