// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_set_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserSetDataState extends UserSetDataState {
  @override
  final SetState added;
  @override
  final BuiltList<int> ids;
  @override
  final LoaderState loader;
  @override
  final BuiltMap<int, SetState> items;

  factory _$UserSetDataState(
          [void Function(UserSetDataStateBuilder) updates]) =>
      (new UserSetDataStateBuilder()..update(updates)).build();

  _$UserSetDataState._({this.added, this.ids, this.loader, this.items})
      : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('UserSetDataState', 'ids');
    }
    if (loader == null) {
      throw new BuiltValueNullFieldError('UserSetDataState', 'loader');
    }
    if (items == null) {
      throw new BuiltValueNullFieldError('UserSetDataState', 'items');
    }
  }

  @override
  UserSetDataState rebuild(void Function(UserSetDataStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserSetDataStateBuilder toBuilder() =>
      new UserSetDataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSetDataState &&
        added == other.added &&
        ids == other.ids &&
        loader == other.loader &&
        items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, added.hashCode), ids.hashCode), loader.hashCode),
        items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserSetDataState')
          ..add('added', added)
          ..add('ids', ids)
          ..add('loader', loader)
          ..add('items', items))
        .toString();
  }
}

class UserSetDataStateBuilder
    implements Builder<UserSetDataState, UserSetDataStateBuilder> {
  _$UserSetDataState _$v;

  SetStateBuilder _added;
  SetStateBuilder get added => _$this._added ??= new SetStateBuilder();
  set added(SetStateBuilder added) => _$this._added = added;

  ListBuilder<int> _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int> ids) => _$this._ids = ids;

  LoaderState _loader;
  LoaderState get loader => _$this._loader;
  set loader(LoaderState loader) => _$this._loader = loader;

  MapBuilder<int, SetState> _items;
  MapBuilder<int, SetState> get items =>
      _$this._items ??= new MapBuilder<int, SetState>();
  set items(MapBuilder<int, SetState> items) => _$this._items = items;

  UserSetDataStateBuilder();

  UserSetDataStateBuilder get _$this {
    if (_$v != null) {
      _added = _$v.added?.toBuilder();
      _ids = _$v.ids?.toBuilder();
      _loader = _$v.loader;
      _items = _$v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserSetDataState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserSetDataState;
  }

  @override
  void update(void Function(UserSetDataStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserSetDataState build() {
    _$UserSetDataState _$result;
    try {
      _$result = _$v ??
          new _$UserSetDataState._(
              added: _added?.build(),
              ids: ids.build(),
              loader: loader,
              items: items.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'added';
        _added?.build();
        _$failedField = 'ids';
        ids.build();

        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserSetDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
