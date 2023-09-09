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
  final BuiltList<int> defaultSetIds;
  @override
  final BuiltList<int> userSetIds;

  factory _$SetDataState([void Function(SetDataStateBuilder)? updates]) =>
      (new SetDataStateBuilder()..update(updates))._build();

  _$SetDataState._(
      {required this.items,
      required this.loader,
      required this.defaultSetIds,
      required this.userSetIds})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(items, r'SetDataState', 'items');
    BuiltValueNullFieldError.checkNotNull(loader, r'SetDataState', 'loader');
    BuiltValueNullFieldError.checkNotNull(
        defaultSetIds, r'SetDataState', 'defaultSetIds');
    BuiltValueNullFieldError.checkNotNull(
        userSetIds, r'SetDataState', 'userSetIds');
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
        defaultSetIds == other.defaultSetIds &&
        userSetIds == other.userSetIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, loader.hashCode);
    _$hash = $jc(_$hash, defaultSetIds.hashCode);
    _$hash = $jc(_$hash, userSetIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetDataState')
          ..add('items', items)
          ..add('loader', loader)
          ..add('defaultSetIds', defaultSetIds)
          ..add('userSetIds', userSetIds))
        .toString();
  }
}

class SetDataStateBuilder
    implements Builder<SetDataState, SetDataStateBuilder> {
  _$SetDataState? _$v;

  MapBuilder<int, SetState>? _items;
  MapBuilder<int, SetState> get items =>
      _$this._items ??= new MapBuilder<int, SetState>();
  set items(MapBuilder<int, SetState>? items) => _$this._items = items;

  LoaderState? _loader;
  LoaderState? get loader => _$this._loader;
  set loader(LoaderState? loader) => _$this._loader = loader;

  ListBuilder<int>? _defaultSetIds;
  ListBuilder<int> get defaultSetIds =>
      _$this._defaultSetIds ??= new ListBuilder<int>();
  set defaultSetIds(ListBuilder<int>? defaultSetIds) =>
      _$this._defaultSetIds = defaultSetIds;

  ListBuilder<int>? _userSetIds;
  ListBuilder<int> get userSetIds =>
      _$this._userSetIds ??= new ListBuilder<int>();
  set userSetIds(ListBuilder<int>? userSetIds) =>
      _$this._userSetIds = userSetIds;

  SetDataStateBuilder();

  SetDataStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _loader = $v.loader;
      _defaultSetIds = $v.defaultSetIds.toBuilder();
      _userSetIds = $v.userSetIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetDataState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SetDataState;
  }

  @override
  void update(void Function(SetDataStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetDataState build() => _build();

  _$SetDataState _build() {
    _$SetDataState _$result;
    try {
      _$result = _$v ??
          new _$SetDataState._(
              items: items.build(),
              loader: BuiltValueNullFieldError.checkNotNull(
                  loader, r'SetDataState', 'loader'),
              defaultSetIds: defaultSetIds.build(),
              userSetIds: userSetIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();

        _$failedField = 'defaultSetIds';
        defaultSetIds.build();
        _$failedField = 'userSetIds';
        userSetIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SetDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
