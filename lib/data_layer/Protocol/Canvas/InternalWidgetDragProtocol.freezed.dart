// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'InternalWidgetDragProtocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
InternalWidgetDragProtocol _$InternalWidgetDragProtocolFromJson(
  Map<String, dynamic> json
) {
    return _Item.fromJson(
      json
    );
}

/// @nodoc
mixin _$InternalWidgetDragProtocol {

// --- Parent Fields ---
 String get url; String get name; String get imageUrl; String get alias; String get dateAdded; int get widgetID;// --- UI Fields (From your Flutter Code) ---
// We exclude Icon/String from JSON because they aren't natively serializable
@JsonKey(includeFromJson: false, includeToJson: false) String get color;// @JsonKey(includeFromJson: false, includeToJson: false) @Default(Icon(Icons.rectangle)) Icon icon,
// --- State Fields ---
 bool get isStay; bool get isTarget; int get score;
/// Create a copy of InternalWidgetDragProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InternalWidgetDragProtocolCopyWith<InternalWidgetDragProtocol> get copyWith => _$InternalWidgetDragProtocolCopyWithImpl<InternalWidgetDragProtocol>(this as InternalWidgetDragProtocol, _$identity);

  /// Serializes this InternalWidgetDragProtocol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InternalWidgetDragProtocol&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.alias, alias) || other.alias == alias)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.widgetID, widgetID) || other.widgetID == widgetID)&&(identical(other.color, color) || other.color == color)&&(identical(other.isStay, isStay) || other.isStay == isStay)&&(identical(other.isTarget, isTarget) || other.isTarget == isTarget)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,imageUrl,alias,dateAdded,widgetID,color,isStay,isTarget,score);

@override
String toString() {
  return 'InternalWidgetDragProtocol(url: $url, name: $name, imageUrl: $imageUrl, alias: $alias, dateAdded: $dateAdded, widgetID: $widgetID, color: $color, isStay: $isStay, isTarget: $isTarget, score: $score)';
}


}

/// @nodoc
abstract mixin class $InternalWidgetDragProtocolCopyWith<$Res>  {
  factory $InternalWidgetDragProtocolCopyWith(InternalWidgetDragProtocol value, $Res Function(InternalWidgetDragProtocol) _then) = _$InternalWidgetDragProtocolCopyWithImpl;
@useResult
$Res call({
 String url, String name, String imageUrl, String alias, String dateAdded, int widgetID,@JsonKey(includeFromJson: false, includeToJson: false) String color, bool isStay, bool isTarget, int score
});




}
/// @nodoc
class _$InternalWidgetDragProtocolCopyWithImpl<$Res>
    implements $InternalWidgetDragProtocolCopyWith<$Res> {
  _$InternalWidgetDragProtocolCopyWithImpl(this._self, this._then);

  final InternalWidgetDragProtocol _self;
  final $Res Function(InternalWidgetDragProtocol) _then;

/// Create a copy of InternalWidgetDragProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? name = null,Object? imageUrl = null,Object? alias = null,Object? dateAdded = null,Object? widgetID = null,Object? color = null,Object? isStay = null,Object? isTarget = null,Object? score = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,alias: null == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String,dateAdded: null == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as String,widgetID: null == widgetID ? _self.widgetID : widgetID // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,isStay: null == isStay ? _self.isStay : isStay // ignore: cast_nullable_to_non_nullable
as bool,isTarget: null == isTarget ? _self.isTarget : isTarget // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InternalWidgetDragProtocol].
extension InternalWidgetDragProtocolPatterns on InternalWidgetDragProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Item value)?  item,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Item() when item != null:
return item(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Item value)  item,}){
final _that = this;
switch (_that) {
case _Item():
return item(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Item value)?  item,}){
final _that = this;
switch (_that) {
case _Item() when item != null:
return item(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String url,  String name,  String imageUrl,  String alias,  String dateAdded,  int widgetID, @JsonKey(includeFromJson: false, includeToJson: false)  String color,  bool isStay,  bool isTarget,  int score)?  item,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Item() when item != null:
return item(_that.url,_that.name,_that.imageUrl,_that.alias,_that.dateAdded,_that.widgetID,_that.color,_that.isStay,_that.isTarget,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String url,  String name,  String imageUrl,  String alias,  String dateAdded,  int widgetID, @JsonKey(includeFromJson: false, includeToJson: false)  String color,  bool isStay,  bool isTarget,  int score)  item,}) {final _that = this;
switch (_that) {
case _Item():
return item(_that.url,_that.name,_that.imageUrl,_that.alias,_that.dateAdded,_that.widgetID,_that.color,_that.isStay,_that.isTarget,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String url,  String name,  String imageUrl,  String alias,  String dateAdded,  int widgetID, @JsonKey(includeFromJson: false, includeToJson: false)  String color,  bool isStay,  bool isTarget,  int score)?  item,}) {final _that = this;
switch (_that) {
case _Item() when item != null:
return item(_that.url,_that.name,_that.imageUrl,_that.alias,_that.dateAdded,_that.widgetID,_that.color,_that.isStay,_that.isTarget,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Item extends InternalWidgetDragProtocol {
   _Item({required this.url, required this.name, required this.imageUrl, required this.alias, required this.dateAdded, required this.widgetID, @JsonKey(includeFromJson: false, includeToJson: false) this.color = 'white', this.isStay = false, this.isTarget = false, this.score = 0}): super._();
  factory _Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

// --- Parent Fields ---
@override final  String url;
@override final  String name;
@override final  String imageUrl;
@override final  String alias;
@override final  String dateAdded;
@override final  int widgetID;
// --- UI Fields (From your Flutter Code) ---
// We exclude Icon/String from JSON because they aren't natively serializable
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String color;
// @JsonKey(includeFromJson: false, includeToJson: false) @Default(Icon(Icons.rectangle)) Icon icon,
// --- State Fields ---
@override@JsonKey() final  bool isStay;
@override@JsonKey() final  bool isTarget;
@override@JsonKey() final  int score;

/// Create a copy of InternalWidgetDragProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemCopyWith<_Item> get copyWith => __$ItemCopyWithImpl<_Item>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Item&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.alias, alias) || other.alias == alias)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.widgetID, widgetID) || other.widgetID == widgetID)&&(identical(other.color, color) || other.color == color)&&(identical(other.isStay, isStay) || other.isStay == isStay)&&(identical(other.isTarget, isTarget) || other.isTarget == isTarget)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,imageUrl,alias,dateAdded,widgetID,color,isStay,isTarget,score);

@override
String toString() {
  return 'InternalWidgetDragProtocol.item(url: $url, name: $name, imageUrl: $imageUrl, alias: $alias, dateAdded: $dateAdded, widgetID: $widgetID, color: $color, isStay: $isStay, isTarget: $isTarget, score: $score)';
}


}

/// @nodoc
abstract mixin class _$ItemCopyWith<$Res> implements $InternalWidgetDragProtocolCopyWith<$Res> {
  factory _$ItemCopyWith(_Item value, $Res Function(_Item) _then) = __$ItemCopyWithImpl;
@override @useResult
$Res call({
 String url, String name, String imageUrl, String alias, String dateAdded, int widgetID,@JsonKey(includeFromJson: false, includeToJson: false) String color, bool isStay, bool isTarget, int score
});




}
/// @nodoc
class __$ItemCopyWithImpl<$Res>
    implements _$ItemCopyWith<$Res> {
  __$ItemCopyWithImpl(this._self, this._then);

  final _Item _self;
  final $Res Function(_Item) _then;

/// Create a copy of InternalWidgetDragProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? name = null,Object? imageUrl = null,Object? alias = null,Object? dateAdded = null,Object? widgetID = null,Object? color = null,Object? isStay = null,Object? isTarget = null,Object? score = null,}) {
  return _then(_Item(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,alias: null == alias ? _self.alias : alias // ignore: cast_nullable_to_non_nullable
as String,dateAdded: null == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as String,widgetID: null == widgetID ? _self.widgetID : widgetID // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,isStay: null == isStay ? _self.isStay : isStay // ignore: cast_nullable_to_non_nullable
as bool,isTarget: null == isTarget ? _self.isTarget : isTarget // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
