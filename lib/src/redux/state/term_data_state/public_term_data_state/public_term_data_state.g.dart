// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_term_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PublicTermDataState extends PublicTermDataState {
  @override
  final BuiltList<int> ids;
  @override
  final LoaderState loader;

  factory _$PublicTermDataState(
          [void Function(PublicTermDataStateBuilder) updates]) =>
      (new PublicTermDataStateBuilder()..update(updates)).build();

  _$PublicTermDataState._({this.ids, this.loader}) : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('PublicTermDataState', 'ids');
    }
    if (loader == null) {
      throw new BuiltValueNullFieldError('PublicTermDataState', 'loader');
    }
  }

  @override
  PublicTermDataState rebuild(
          void Function(PublicTermDataStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PublicTermDataStateBuilder toBuilder() =>
      new PublicTermDataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicTermDataState &&
        ids == other.ids &&
        loader == other.loader;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, ids.hashCode), loader.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PublicTermDataState')
          ..add('ids', ids)
          ..add('loader', loader))
        .toString();
  }
}

class PublicTermDataStateBuilder
    implements Builder<PublicTermDataState, PublicTermDataStateBuilder> {
  _$PublicTermDataState _$v;

  ListBuilder<int> _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int> ids) => _$this._ids = ids;

  LoaderState _loader;
  LoaderState get loader => _$this._loader;
  set loader(LoaderState loader) => _$this._loader = loader;

  PublicTermDataStateBuilder();

  PublicTermDataStateBuilder get _$this {
    if (_$v != null) {
      _ids = _$v.ids?.toBuilder();
      _loader = _$v.loader;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PublicTermDataState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PublicTermDataState;
  }

  @override
  void update(void Function(PublicTermDataStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PublicTermDataState build() {
    _$PublicTermDataState _$result;
    try {
      _$result =
          _$v ?? new _$PublicTermDataState._(ids: ids.build(), loader: loader);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PublicTermDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
