// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SetModel _$SetModelFromJson(Map<String, dynamic> json) {
  return _SetModel.fromJson(json);
}

/// @nodoc
mixin _$SetModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  TermsModel get terms => throw _privateConstructorUsedError;
  int? get parentId => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SetModelCopyWith<SetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetModelCopyWith<$Res> {
  factory $SetModelCopyWith(SetModel value, $Res Function(SetModel) then) =
      _$SetModelCopyWithImpl<$Res, SetModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      bool isDefault,
      TermsModel terms,
      int? parentId,
      String? icon});

  $TermsModelCopyWith<$Res> get terms;
}

/// @nodoc
class _$SetModelCopyWithImpl<$Res, $Val extends SetModel>
    implements $SetModelCopyWith<$Res> {
  _$SetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDefault = null,
    Object? terms = null,
    Object? parentId = freezed,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      terms: null == terms
          ? _value.terms
          : terms // ignore: cast_nullable_to_non_nullable
              as TermsModel,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TermsModelCopyWith<$Res> get terms {
    return $TermsModelCopyWith<$Res>(_value.terms, (value) {
      return _then(_value.copyWith(terms: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SetModelImplCopyWith<$Res>
    implements $SetModelCopyWith<$Res> {
  factory _$$SetModelImplCopyWith(
          _$SetModelImpl value, $Res Function(_$SetModelImpl) then) =
      __$$SetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      bool isDefault,
      TermsModel terms,
      int? parentId,
      String? icon});

  @override
  $TermsModelCopyWith<$Res> get terms;
}

/// @nodoc
class __$$SetModelImplCopyWithImpl<$Res>
    extends _$SetModelCopyWithImpl<$Res, _$SetModelImpl>
    implements _$$SetModelImplCopyWith<$Res> {
  __$$SetModelImplCopyWithImpl(
      _$SetModelImpl _value, $Res Function(_$SetModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDefault = null,
    Object? terms = null,
    Object? parentId = freezed,
    Object? icon = freezed,
  }) {
    return _then(_$SetModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      terms: null == terms
          ? _value.terms
          : terms // ignore: cast_nullable_to_non_nullable
              as TermsModel,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetModelImpl extends _SetModel with DiagnosticableTreeMixin {
  const _$SetModelImpl(
      {required this.id,
      required this.name,
      required this.isDefault,
      required this.terms,
      this.parentId,
      this.icon})
      : super._();

  factory _$SetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SetModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final bool isDefault;
  @override
  final TermsModel terms;
  @override
  final int? parentId;
  @override
  final String? icon;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SetModel(id: $id, name: $name, isDefault: $isDefault, terms: $terms, parentId: $parentId, icon: $icon)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SetModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('isDefault', isDefault))
      ..add(DiagnosticsProperty('terms', terms))
      ..add(DiagnosticsProperty('parentId', parentId))
      ..add(DiagnosticsProperty('icon', icon));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.terms, terms) || other.terms == terms) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, isDefault, terms, parentId, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetModelImplCopyWith<_$SetModelImpl> get copyWith =>
      __$$SetModelImplCopyWithImpl<_$SetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SetModelImplToJson(
      this,
    );
  }
}

abstract class _SetModel extends SetModel {
  const factory _SetModel(
      {required final int id,
      required final String name,
      required final bool isDefault,
      required final TermsModel terms,
      final int? parentId,
      final String? icon}) = _$SetModelImpl;
  const _SetModel._() : super._();

  factory _SetModel.fromJson(Map<String, dynamic> json) =
      _$SetModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  bool get isDefault;
  @override
  TermsModel get terms;
  @override
  int? get parentId;
  @override
  String? get icon;
  @override
  @JsonKey(ignore: true)
  _$$SetModelImplCopyWith<_$SetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
