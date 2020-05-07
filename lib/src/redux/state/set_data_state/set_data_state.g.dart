// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetDataState extends SetDataState {
  @override
  final BuiltMap<int, SetState> items;
  @override
  final LoaderState loader;
  @override
  final BuiltList<int> publicSetIds;
  @override
  final BuiltList<int> userSetIds;

  factory _$SetDataState([void Function(SetDataStateBuilder) updates]) =>
      (new SetDataStateBuilder()..update(updates)).build();

  _$SetDataState._(
      {this.items, this.loader, this.publicSetIds, this.userSetIds})
      : super._() {
    if (items == null) {
      throw new BuiltValueNullFieldError('SetDataState', 'items');
    }
    if (loader == null) {
      throw new BuiltValueNullFieldError('SetDataState', 'loader');
    }
    if (publicSetIds == null) {
      throw new BuiltValueNullFieldError('SetDataState', 'publicSetIds');
    }
    if (userSetIds == null) {
      throw new BuiltValueNullFieldError('SetDataState', 'userSetIds');
    }
  }

  @override
  SetDataState rebuild(void Function(SetDataStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetDataStateBuilder toBuilder() => new SetDataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetDataState &&
        items == other.items &&
        loader == other.loader &&
        publicSetIds == other.publicSetIds &&
        userSetIds == other.userSetIds;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, items.hashCode), loader.hashCode),
            publicSetIds.hashCode),
        userSetIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetDataState')
          ..add('items', items)
          ..add('loader', loader)
          ..add('publicSetIds', publicSetIds)
          ..add('userSetIds', userSetIds))
        .toString();
  }
}

class SetDataStateBuilder
    implements Builder<SetDataState, SetDataStateBuilder> {
  _$SetDataState _$v;

  MapBuilder<int, SetState> _items;
  MapBuilder<int, SetState> get items =>
      _$this._items ??= new MapBuilder<int, SetState>();
  set items(MapBuilder<int, SetState> items) => _$this._items = items;

  LoaderState _loader;
  LoaderState get loader => _$this._loader;
  set loader(LoaderState loader) => _$this._loader = loader;

  ListBuilder<int> _publicSetIds;
  ListBuilder<int> get publicSetIds =>
      _$this._publicSetIds ??= new ListBuilder<int>();
  set publicSetIds(ListBuilder<int> publicSetIds) =>
      _$this._publicSetIds = publicSetIds;

  ListBuilder<int> _userSetIds;
  ListBuilder<int> get userSetIds =>
      _$this._userSetIds ??= new ListBuilder<int>();
  set userSetIds(ListBuilder<int> userSetIds) =>
      _$this._userSetIds = userSetIds;

  SetDataStateBuilder();

  SetDataStateBuilder get _$this {
    if (_$v != null) {
      _items = _$v.items?.toBuilder();
      _loader = _$v.loader;
      _publicSetIds = _$v.publicSetIds?.toBuilder();
      _userSetIds = _$v.userSetIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetDataState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SetDataState;
  }

  @override
  void update(void Function(SetDataStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SetDataState build() {
    _$SetDataState _$result;
    try {
      _$result = _$v ??
          new _$SetDataState._(
              items: items.build(),
              loader: loader,
              publicSetIds: publicSetIds.build(),
              userSetIds: userSetIds.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        items.build();

        _$failedField = 'publicSetIds';
        publicSetIds.build();
        _$failedField = 'userSetIds';
        userSetIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SetDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
