// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_term_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserTermDataState extends UserTermDataState {
  @override
  final TermState added;
  @override
  final BuiltList<int> ids;
  @override
  final LoaderState loader;

  factory _$UserTermDataState(
          [void Function(UserTermDataStateBuilder) updates]) =>
      (new UserTermDataStateBuilder()..update(updates)).build();

  _$UserTermDataState._({this.added, this.ids, this.loader}) : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('UserTermDataState', 'ids');
    }
    if (loader == null) {
      throw new BuiltValueNullFieldError('UserTermDataState', 'loader');
    }
  }

  @override
  UserTermDataState rebuild(void Function(UserTermDataStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserTermDataStateBuilder toBuilder() =>
      new UserTermDataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserTermDataState &&
        added == other.added &&
        ids == other.ids &&
        loader == other.loader;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, added.hashCode), ids.hashCode), loader.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserTermDataState')
          ..add('added', added)
          ..add('ids', ids)
          ..add('loader', loader))
        .toString();
  }
}

class UserTermDataStateBuilder
    implements Builder<UserTermDataState, UserTermDataStateBuilder> {
  _$UserTermDataState _$v;

  TermStateBuilder _added;
  TermStateBuilder get added => _$this._added ??= new TermStateBuilder();
  set added(TermStateBuilder added) => _$this._added = added;

  ListBuilder<int> _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int> ids) => _$this._ids = ids;

  LoaderState _loader;
  LoaderState get loader => _$this._loader;
  set loader(LoaderState loader) => _$this._loader = loader;

  UserTermDataStateBuilder();

  UserTermDataStateBuilder get _$this {
    if (_$v != null) {
      _added = _$v.added?.toBuilder();
      _ids = _$v.ids?.toBuilder();
      _loader = _$v.loader;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserTermDataState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserTermDataState;
  }

  @override
  void update(void Function(UserTermDataStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserTermDataState build() {
    _$UserTermDataState _$result;
    try {
      _$result = _$v ??
          new _$UserTermDataState._(
              added: _added?.build(), ids: ids.build(), loader: loader);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'added';
        _added?.build();
        _$failedField = 'ids';
        ids.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserTermDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
