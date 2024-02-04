// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sets_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SetsModel _$SetsModelFromJson(Map<String, dynamic> json) {
  return _SetsModel.fromJson(json);
}

/// @nodoc
mixin _$SetsModel {
  List<int> get ids => throw _privateConstructorUsedError;
  Map<int, SetModel> get sets => throw _privateConstructorUsedError;
  bool get isLoaded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SetsModelCopyWith<SetsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetsModelCopyWith<$Res> {
  factory $SetsModelCopyWith(SetsModel value, $Res Function(SetsModel) then) =
      _$SetsModelCopyWithImpl<$Res, SetsModel>;
  @useResult
  $Res call({List<int> ids, Map<int, SetModel> sets, bool isLoaded});
}

/// @nodoc
class _$SetsModelCopyWithImpl<$Res, $Val extends SetsModel>
    implements $SetsModelCopyWith<$Res> {
  _$SetsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? sets = null,
    Object? isLoaded = null,
  }) {
    return _then(_value.copyWith(
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<int>,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as Map<int, SetModel>,
      isLoaded: null == isLoaded
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetsModelImplCopyWith<$Res>
    implements $SetsModelCopyWith<$Res> {
  factory _$$SetsModelImplCopyWith(
          _$SetsModelImpl value, $Res Function(_$SetsModelImpl) then) =
      __$$SetsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> ids, Map<int, SetModel> sets, bool isLoaded});
}

/// @nodoc
class __$$SetsModelImplCopyWithImpl<$Res>
    extends _$SetsModelCopyWithImpl<$Res, _$SetsModelImpl>
    implements _$$SetsModelImplCopyWith<$Res> {
  __$$SetsModelImplCopyWithImpl(
      _$SetsModelImpl _value, $Res Function(_$SetsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
    Object? sets = null,
    Object? isLoaded = null,
  }) {
    return _then(_$SetsModelImpl(
      ids: null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<int>,
      sets: null == sets
          ? _value._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as Map<int, SetModel>,
      isLoaded: null == isLoaded
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetsModelImpl with DiagnosticableTreeMixin implements _SetsModel {
  const _$SetsModelImpl(
      {required final List<int> ids,
      required final Map<int, SetModel> sets,
      required this.isLoaded})
      : _ids = ids,
        _sets = sets;

  factory _$SetsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SetsModelImplFromJson(json);

  final List<int> _ids;
  @override
  List<int> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  final Map<int, SetModel> _sets;
  @override
  Map<int, SetModel> get sets {
    if (_sets is EqualUnmodifiableMapView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sets);
  }

  @override
  final bool isLoaded;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SetsModel(ids: $ids, sets: $sets, isLoaded: $isLoaded)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SetsModel'))
      ..add(DiagnosticsProperty('ids', ids))
      ..add(DiagnosticsProperty('sets', sets))
      ..add(DiagnosticsProperty('isLoaded', isLoaded));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetsModelImpl &&
            const DeepCollectionEquality().equals(other._ids, _ids) &&
            const DeepCollectionEquality().equals(other._sets, _sets) &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_ids),
      const DeepCollectionEquality().hash(_sets),
      isLoaded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetsModelImplCopyWith<_$SetsModelImpl> get copyWith =>
      __$$SetsModelImplCopyWithImpl<_$SetsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SetsModelImplToJson(
      this,
    );
  }
}

abstract class _SetsModel implements SetsModel {
  const factory _SetsModel(
      {required final List<int> ids,
      required final Map<int, SetModel> sets,
      required final bool isLoaded}) = _$SetsModelImpl;

  factory _SetsModel.fromJson(Map<String, dynamic> json) =
      _$SetsModelImpl.fromJson;

  @override
  List<int> get ids;
  @override
  Map<int, SetModel> get sets;
  @override
  bool get isLoaded;
  @override
  @JsonKey(ignore: true)
  _$$SetsModelImplCopyWith<_$SetsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
