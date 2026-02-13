// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PersonalInformationProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PersonalInformationProtocol {

 String get name; String get email; String get username; String? get phoneNumber; String? get address; String? get gender; String? get city; String? get country; String? get birthday; String? get bio; String? get occupation; String? get profileImageUrl; bool get isActive; String? get company; String? get website; String? get postalCode;
/// Create a copy of PersonalInformationProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalInformationProtocolCopyWith<PersonalInformationProtocol> get copyWith => _$PersonalInformationProtocolCopyWithImpl<PersonalInformationProtocol>(this as PersonalInformationProtocol, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalInformationProtocol&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.company, company) || other.company == company)&&(identical(other.website, website) || other.website == website)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,username,phoneNumber,address,gender,city,country,birthday,bio,occupation,profileImageUrl,isActive,company,website,postalCode);

@override
String toString() {
  return 'PersonalInformationProtocol(name: $name, email: $email, username: $username, phoneNumber: $phoneNumber, address: $address, gender: $gender, city: $city, country: $country, birthday: $birthday, bio: $bio, occupation: $occupation, profileImageUrl: $profileImageUrl, isActive: $isActive, company: $company, website: $website, postalCode: $postalCode)';
}


}

/// @nodoc
abstract mixin class $PersonalInformationProtocolCopyWith<$Res>  {
  factory $PersonalInformationProtocolCopyWith(PersonalInformationProtocol value, $Res Function(PersonalInformationProtocol) _then) = _$PersonalInformationProtocolCopyWithImpl;
@useResult
$Res call({
 String name, String email, String username, String? phoneNumber, String? address, String? gender, String? city, String? country, String? birthday, String? bio, String? occupation, String? profileImageUrl, bool isActive, String? company, String? website, String? postalCode
});




}
/// @nodoc
class _$PersonalInformationProtocolCopyWithImpl<$Res>
    implements $PersonalInformationProtocolCopyWith<$Res> {
  _$PersonalInformationProtocolCopyWithImpl(this._self, this._then);

  final PersonalInformationProtocol _self;
  final $Res Function(PersonalInformationProtocol) _then;

/// Create a copy of PersonalInformationProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? username = null,Object? phoneNumber = freezed,Object? address = freezed,Object? gender = freezed,Object? city = freezed,Object? country = freezed,Object? birthday = freezed,Object? bio = freezed,Object? occupation = freezed,Object? profileImageUrl = freezed,Object? isActive = null,Object? company = freezed,Object? website = freezed,Object? postalCode = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalInformationProtocol].
extension PersonalInformationProtocolPatterns on PersonalInformationProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalInformationProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalInformationProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalInformationProtocol value)  $default,){
final _that = this;
switch (_that) {
case _PersonalInformationProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalInformationProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalInformationProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String username,  String? phoneNumber,  String? address,  String? gender,  String? city,  String? country,  String? birthday,  String? bio,  String? occupation,  String? profileImageUrl,  bool isActive,  String? company,  String? website,  String? postalCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalInformationProtocol() when $default != null:
return $default(_that.name,_that.email,_that.username,_that.phoneNumber,_that.address,_that.gender,_that.city,_that.country,_that.birthday,_that.bio,_that.occupation,_that.profileImageUrl,_that.isActive,_that.company,_that.website,_that.postalCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String username,  String? phoneNumber,  String? address,  String? gender,  String? city,  String? country,  String? birthday,  String? bio,  String? occupation,  String? profileImageUrl,  bool isActive,  String? company,  String? website,  String? postalCode)  $default,) {final _that = this;
switch (_that) {
case _PersonalInformationProtocol():
return $default(_that.name,_that.email,_that.username,_that.phoneNumber,_that.address,_that.gender,_that.city,_that.country,_that.birthday,_that.bio,_that.occupation,_that.profileImageUrl,_that.isActive,_that.company,_that.website,_that.postalCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String username,  String? phoneNumber,  String? address,  String? gender,  String? city,  String? country,  String? birthday,  String? bio,  String? occupation,  String? profileImageUrl,  bool isActive,  String? company,  String? website,  String? postalCode)?  $default,) {final _that = this;
switch (_that) {
case _PersonalInformationProtocol() when $default != null:
return $default(_that.name,_that.email,_that.username,_that.phoneNumber,_that.address,_that.gender,_that.city,_that.country,_that.birthday,_that.bio,_that.occupation,_that.profileImageUrl,_that.isActive,_that.company,_that.website,_that.postalCode);case _:
  return null;

}
}

}

/// @nodoc


class _PersonalInformationProtocol implements PersonalInformationProtocol {
   _PersonalInformationProtocol({required this.name, required this.email, required this.username, this.phoneNumber, this.address, this.gender, this.city, this.country, this.birthday, this.bio, this.occupation, this.profileImageUrl, required this.isActive, this.company, this.website, this.postalCode});
  

@override final  String name;
@override final  String email;
@override final  String username;
@override final  String? phoneNumber;
@override final  String? address;
@override final  String? gender;
@override final  String? city;
@override final  String? country;
@override final  String? birthday;
@override final  String? bio;
@override final  String? occupation;
@override final  String? profileImageUrl;
@override final  bool isActive;
@override final  String? company;
@override final  String? website;
@override final  String? postalCode;

/// Create a copy of PersonalInformationProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalInformationProtocolCopyWith<_PersonalInformationProtocol> get copyWith => __$PersonalInformationProtocolCopyWithImpl<_PersonalInformationProtocol>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalInformationProtocol&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.company, company) || other.company == company)&&(identical(other.website, website) || other.website == website)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,username,phoneNumber,address,gender,city,country,birthday,bio,occupation,profileImageUrl,isActive,company,website,postalCode);

@override
String toString() {
  return 'PersonalInformationProtocol(name: $name, email: $email, username: $username, phoneNumber: $phoneNumber, address: $address, gender: $gender, city: $city, country: $country, birthday: $birthday, bio: $bio, occupation: $occupation, profileImageUrl: $profileImageUrl, isActive: $isActive, company: $company, website: $website, postalCode: $postalCode)';
}


}

/// @nodoc
abstract mixin class _$PersonalInformationProtocolCopyWith<$Res> implements $PersonalInformationProtocolCopyWith<$Res> {
  factory _$PersonalInformationProtocolCopyWith(_PersonalInformationProtocol value, $Res Function(_PersonalInformationProtocol) _then) = __$PersonalInformationProtocolCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String username, String? phoneNumber, String? address, String? gender, String? city, String? country, String? birthday, String? bio, String? occupation, String? profileImageUrl, bool isActive, String? company, String? website, String? postalCode
});




}
/// @nodoc
class __$PersonalInformationProtocolCopyWithImpl<$Res>
    implements _$PersonalInformationProtocolCopyWith<$Res> {
  __$PersonalInformationProtocolCopyWithImpl(this._self, this._then);

  final _PersonalInformationProtocol _self;
  final $Res Function(_PersonalInformationProtocol) _then;

/// Create a copy of PersonalInformationProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? username = null,Object? phoneNumber = freezed,Object? address = freezed,Object? gender = freezed,Object? city = freezed,Object? country = freezed,Object? birthday = freezed,Object? bio = freezed,Object? occupation = freezed,Object? profileImageUrl = freezed,Object? isActive = null,Object? company = freezed,Object? website = freezed,Object? postalCode = freezed,}) {
  return _then(_PersonalInformationProtocol(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
