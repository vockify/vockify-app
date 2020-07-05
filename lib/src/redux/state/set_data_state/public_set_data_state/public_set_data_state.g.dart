// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_set_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PublicSetDataState extends PublicSetDataState {
  @override
  final BuiltList<int> ids;
  @override
  final LoaderState loader;

  factory _$PublicSetDataState(
          [void Function(PublicSetDataStateBuilder) updates]) =>
      (new PublicSetDataStateBuilder()..update(updates)).build();

  _$PublicSetDataState._({this.ids, this.loader}) : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('PublicSetDataState', 'ids');
    }
    if (loader == null) {
      throw new BuiltValueNullFieldError('PublicSetDataState', 'loader');
    }
  }

  @override
  PublicSetDataState rebuild(
          void Function(PublicSetDataStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PublicSetDataStateBuilder toBuilder() =>
      new PublicSetDataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicSetDataState &&
        ids == other.ids &&
        loader == other.loader;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, ids.hashCode), loader.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PublicSetDataState')
          ..add('ids', ids)
          ..add('loader', loader))
        .toString();
  }
}

class PublicSetDataStateBuilder
    implements Builder<PublicSetDataState, PublicSetDataStateBuilder> {
  _$PublicSetDataState _$v;

  ListBuilder<int> _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int> ids) => _$this._ids = ids;

  LoaderState _loader;
  LoaderState get loader => _$this._loader;
  set loader(LoaderState loader) => _$this._loader = loader;

  PublicSetDataStateBuilder();

  PublicSetDataStateBuilder get _$this {
    if (_$v != null) {
      _ids = _$v.ids?.toBuilder();
      _loader = _$v.loader;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PublicSetDataState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PublicSetDataState;
  }

  @override
  void update(void Function(PublicSetDataStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PublicSetDataState build() {
    _$PublicSetDataState _$result;
    try {
      _$result =
          _$v ?? new _$PublicSetDataState._(ids: ids.build(), loader: loader);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PublicSetDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
