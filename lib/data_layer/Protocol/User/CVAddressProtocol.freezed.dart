// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'CVAddressProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CVAddressProtocol {

 int get cvAddressID; int get personID; String? get githubUrl; String? get websiteUrl; String? get company; String? get university; String? get location; String? get country; String? get bio; String? get occupation; String? get educationLevel; String? get linkedinUrl;
/// Create a copy of CVAddressProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CVAddressProtocolCopyWith<CVAddressProtocol> get copyWith => _$CVAddressProtocolCopyWithImpl<CVAddressProtocol>(this as CVAddressProtocol, _$identity);

  /// Serializes this CVAddressProtocol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CVAddressProtocol&&(identical(other.cvAddressID, cvAddressID) || other.cvAddressID == cvAddressID)&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.githubUrl, githubUrl) || other.githubUrl == githubUrl)&&(identical(other.websiteUrl, websiteUrl) || other.websiteUrl == websiteUrl)&&(identical(other.company, company) || other.company == company)&&(identical(other.university, university) || other.university == university)&&(identical(other.location, location) || other.location == location)&&(identical(other.country, country) || other.country == country)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.educationLevel, educationLevel) || other.educationLevel == educationLevel)&&(identical(other.linkedinUrl, linkedinUrl) || other.linkedinUrl == linkedinUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cvAddressID,personID,githubUrl,websiteUrl,company,university,location,country,bio,occupation,educationLevel,linkedinUrl);

@override
String toString() {
  return 'CVAddressProtocol(cvAddressID: $cvAddressID, personID: $personID, githubUrl: $githubUrl, websiteUrl: $websiteUrl, company: $company, university: $university, location: $location, country: $country, bio: $bio, occupation: $occupation, educationLevel: $educationLevel, linkedinUrl: $linkedinUrl)';
}


}

/// @nodoc
abstract mixin class $CVAddressProtocolCopyWith<$Res>  {
  factory $CVAddressProtocolCopyWith(CVAddressProtocol value, $Res Function(CVAddressProtocol) _then) = _$CVAddressProtocolCopyWithImpl;
@useResult
$Res call({
 int cvAddressID, int personID, String? githubUrl, String? websiteUrl, String? company, String? university, String? location, String? country, String? bio, String? occupation, String? educationLevel, String? linkedinUrl
});




}
/// @nodoc
class _$CVAddressProtocolCopyWithImpl<$Res>
    implements $CVAddressProtocolCopyWith<$Res> {
  _$CVAddressProtocolCopyWithImpl(this._self, this._then);

  final CVAddressProtocol _self;
  final $Res Function(CVAddressProtocol) _then;

/// Create a copy of CVAddressProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cvAddressID = null,Object? personID = null,Object? githubUrl = freezed,Object? websiteUrl = freezed,Object? company = freezed,Object? university = freezed,Object? location = freezed,Object? country = freezed,Object? bio = freezed,Object? occupation = freezed,Object? educationLevel = freezed,Object? linkedinUrl = freezed,}) {
  return _then(_self.copyWith(
cvAddressID: null == cvAddressID ? _self.cvAddressID : cvAddressID // ignore: cast_nullable_to_non_nullable
as int,personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,githubUrl: freezed == githubUrl ? _self.githubUrl : githubUrl // ignore: cast_nullable_to_non_nullable
as String?,websiteUrl: freezed == websiteUrl ? _self.websiteUrl : websiteUrl // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,university: freezed == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,educationLevel: freezed == educationLevel ? _self.educationLevel : educationLevel // ignore: cast_nullable_to_non_nullable
as String?,linkedinUrl: freezed == linkedinUrl ? _self.linkedinUrl : linkedinUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CVAddressProtocol].
extension CVAddressProtocolPatterns on CVAddressProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CVAddressProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CVAddressProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CVAddressProtocol value)  $default,){
final _that = this;
switch (_that) {
case _CVAddressProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CVAddressProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _CVAddressProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cvAddressID,  int personID,  String? githubUrl,  String? websiteUrl,  String? company,  String? university,  String? location,  String? country,  String? bio,  String? occupation,  String? educationLevel,  String? linkedinUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CVAddressProtocol() when $default != null:
return $default(_that.cvAddressID,_that.personID,_that.githubUrl,_that.websiteUrl,_that.company,_that.university,_that.location,_that.country,_that.bio,_that.occupation,_that.educationLevel,_that.linkedinUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cvAddressID,  int personID,  String? githubUrl,  String? websiteUrl,  String? company,  String? university,  String? location,  String? country,  String? bio,  String? occupation,  String? educationLevel,  String? linkedinUrl)  $default,) {final _that = this;
switch (_that) {
case _CVAddressProtocol():
return $default(_that.cvAddressID,_that.personID,_that.githubUrl,_that.websiteUrl,_that.company,_that.university,_that.location,_that.country,_that.bio,_that.occupation,_that.educationLevel,_that.linkedinUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cvAddressID,  int personID,  String? githubUrl,  String? websiteUrl,  String? company,  String? university,  String? location,  String? country,  String? bio,  String? occupation,  String? educationLevel,  String? linkedinUrl)?  $default,) {final _that = this;
switch (_that) {
case _CVAddressProtocol() when $default != null:
return $default(_that.cvAddressID,_that.personID,_that.githubUrl,_that.websiteUrl,_that.company,_that.university,_that.location,_that.country,_that.bio,_that.occupation,_that.educationLevel,_that.linkedinUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CVAddressProtocol implements CVAddressProtocol {
  const _CVAddressProtocol({required this.cvAddressID, required this.personID, this.githubUrl, this.websiteUrl, this.company, this.university, this.location, this.country, this.bio, this.occupation, this.educationLevel, this.linkedinUrl});
  factory _CVAddressProtocol.fromJson(Map<String, dynamic> json) => _$CVAddressProtocolFromJson(json);

@override final  int cvAddressID;
@override final  int personID;
@override final  String? githubUrl;
@override final  String? websiteUrl;
@override final  String? company;
@override final  String? university;
@override final  String? location;
@override final  String? country;
@override final  String? bio;
@override final  String? occupation;
@override final  String? educationLevel;
@override final  String? linkedinUrl;

/// Create a copy of CVAddressProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CVAddressProtocolCopyWith<_CVAddressProtocol> get copyWith => __$CVAddressProtocolCopyWithImpl<_CVAddressProtocol>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CVAddressProtocolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CVAddressProtocol&&(identical(other.cvAddressID, cvAddressID) || other.cvAddressID == cvAddressID)&&(identical(other.personID, personID) || other.personID == personID)&&(identical(other.githubUrl, githubUrl) || other.githubUrl == githubUrl)&&(identical(other.websiteUrl, websiteUrl) || other.websiteUrl == websiteUrl)&&(identical(other.company, company) || other.company == company)&&(identical(other.university, university) || other.university == university)&&(identical(other.location, location) || other.location == location)&&(identical(other.country, country) || other.country == country)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.educationLevel, educationLevel) || other.educationLevel == educationLevel)&&(identical(other.linkedinUrl, linkedinUrl) || other.linkedinUrl == linkedinUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cvAddressID,personID,githubUrl,websiteUrl,company,university,location,country,bio,occupation,educationLevel,linkedinUrl);

@override
String toString() {
  return 'CVAddressProtocol(cvAddressID: $cvAddressID, personID: $personID, githubUrl: $githubUrl, websiteUrl: $websiteUrl, company: $company, university: $university, location: $location, country: $country, bio: $bio, occupation: $occupation, educationLevel: $educationLevel, linkedinUrl: $linkedinUrl)';
}


}

/// @nodoc
abstract mixin class _$CVAddressProtocolCopyWith<$Res> implements $CVAddressProtocolCopyWith<$Res> {
  factory _$CVAddressProtocolCopyWith(_CVAddressProtocol value, $Res Function(_CVAddressProtocol) _then) = __$CVAddressProtocolCopyWithImpl;
@override @useResult
$Res call({
 int cvAddressID, int personID, String? githubUrl, String? websiteUrl, String? company, String? university, String? location, String? country, String? bio, String? occupation, String? educationLevel, String? linkedinUrl
});




}
/// @nodoc
class __$CVAddressProtocolCopyWithImpl<$Res>
    implements _$CVAddressProtocolCopyWith<$Res> {
  __$CVAddressProtocolCopyWithImpl(this._self, this._then);

  final _CVAddressProtocol _self;
  final $Res Function(_CVAddressProtocol) _then;

/// Create a copy of CVAddressProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cvAddressID = null,Object? personID = null,Object? githubUrl = freezed,Object? websiteUrl = freezed,Object? company = freezed,Object? university = freezed,Object? location = freezed,Object? country = freezed,Object? bio = freezed,Object? occupation = freezed,Object? educationLevel = freezed,Object? linkedinUrl = freezed,}) {
  return _then(_CVAddressProtocol(
cvAddressID: null == cvAddressID ? _self.cvAddressID : cvAddressID // ignore: cast_nullable_to_non_nullable
as int,personID: null == personID ? _self.personID : personID // ignore: cast_nullable_to_non_nullable
as int,githubUrl: freezed == githubUrl ? _self.githubUrl : githubUrl // ignore: cast_nullable_to_non_nullable
as String?,websiteUrl: freezed == websiteUrl ? _self.websiteUrl : websiteUrl // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,university: freezed == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,educationLevel: freezed == educationLevel ? _self.educationLevel : educationLevel // ignore: cast_nullable_to_non_nullable
as String?,linkedinUrl: freezed == linkedinUrl ? _self.linkedinUrl : linkedinUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
