// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TermModel _$TermModelFromJson(Map<String, dynamic> json) {
  return _TermModel.fromJson(json);
}

/// @nodoc
mixin _$TermModel {
  int get id => throw _privateConstructorUsedError;
  int get setId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get definition => throw _privateConstructorUsedError;
  MemorizationLevel? get memorizationLevel =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TermModelCopyWith<TermModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermModelCopyWith<$Res> {
  factory $TermModelCopyWith(TermModel value, $Res Function(TermModel) then) =
      _$TermModelCopyWithImpl<$Res, TermModel>;
  @useResult
  $Res call(
      {int id,
      int setId,
      String name,
      String definition,
      MemorizationLevel? memorizationLevel});
}

/// @nodoc
class _$TermModelCopyWithImpl<$Res, $Val extends TermModel>
    implements $TermModelCopyWith<$Res> {
  _$TermModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? setId = null,
    Object? name = null,
    Object? definition = null,
    Object? memorizationLevel = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      setId: null == setId
          ? _value.setId
          : setId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      definition: null == definition
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String,
      memorizationLevel: freezed == memorizationLevel
          ? _value.memorizationLevel
          : memorizationLevel // ignore: cast_nullable_to_non_nullable
              as MemorizationLevel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermModelImplCopyWith<$Res>
    implements $TermModelCopyWith<$Res> {
  factory _$$TermModelImplCopyWith(
          _$TermModelImpl value, $Res Function(_$TermModelImpl) then) =
      __$$TermModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int setId,
      String name,
      String definition,
      MemorizationLevel? memorizationLevel});
}

/// @nodoc
class __$$TermModelImplCopyWithImpl<$Res>
    extends _$TermModelCopyWithImpl<$Res, _$TermModelImpl>
    implements _$$TermModelImplCopyWith<$Res> {
  __$$TermModelImplCopyWithImpl(
      _$TermModelImpl _value, $Res Function(_$TermModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? setId = null,
    Object? name = null,
    Object? definition = null,
    Object? memorizationLevel = freezed,
  }) {
    return _then(_$TermModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      setId: null == setId
          ? _value.setId
          : setId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      definition: null == definition
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String,
      memorizationLevel: freezed == memorizationLevel
          ? _value.memorizationLevel
          : memorizationLevel // ignore: cast_nullable_to_non_nullable
              as MemorizationLevel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermModelImpl extends _TermModel with DiagnosticableTreeMixin {
  const _$TermModelImpl(
      {required this.id,
      required this.setId,
      required this.name,
      required this.definition,
      this.memorizationLevel})
      : super._();

  factory _$TermModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermModelImplFromJson(json);

  @override
  final int id;
  @override
  final int setId;
  @override
  final String name;
  @override
  final String definition;
  @override
  final MemorizationLevel? memorizationLevel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TermModel(id: $id, setId: $setId, name: $name, definition: $definition, memorizationLevel: $memorizationLevel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TermModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('setId', setId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('definition', definition))
      ..add(DiagnosticsProperty('memorizationLevel', memorizationLevel));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.setId, setId) || other.setId == setId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            (identical(other.memorizationLevel, memorizationLevel) ||
                other.memorizationLevel == memorizationLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, setId, name, definition, memorizationLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TermModelImplCopyWith<_$TermModelImpl> get copyWith =>
      __$$TermModelImplCopyWithImpl<_$TermModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermModelImplToJson(
      this,
    );
  }
}

abstract class _TermModel extends TermModel {
  const factory _TermModel(
      {required final int id,
      required final int setId,
      required final String name,
      required final String definition,
      final MemorizationLevel? memorizationLevel}) = _$TermModelImpl;
  const _TermModel._() : super._();

  factory _TermModel.fromJson(Map<String, dynamic> json) =
      _$TermModelImpl.fromJson;

  @override
  int get id;
  @override
  int get setId;
  @override
  String get name;
  @override
  String get definition;
  @override
  MemorizationLevel? get memorizationLevel;
  @override
  @JsonKey(ignore: true)
  _$$TermModelImplCopyWith<_$TermModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
