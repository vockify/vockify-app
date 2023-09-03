// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TermDataState extends TermDataState {
  @override
  final BuiltList<int> ids;
  @override
  final BuiltMap<int, TermState> items;
  @override
  final LoaderState loader;

  factory _$TermDataState([void Function(TermDataStateBuilder)? updates]) =>
      (new TermDataStateBuilder()..update(updates))._build();

  _$TermDataState._(
      {required this.ids, required this.items, required this.loader})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(ids, r'TermDataState', 'ids');
    BuiltValueNullFieldError.checkNotNull(items, r'TermDataState', 'items');
    BuiltValueNullFieldError.checkNotNull(loader, r'TermDataState', 'loader');
  }

  @override
  TermDataState rebuild(void Function(TermDataStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TermDataStateBuilder toBuilder() => new TermDataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermDataState &&
        ids == other.ids &&
        items == other.items &&
        loader == other.loader;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ids.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, loader.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TermDataState')
          ..add('ids', ids)
          ..add('items', items)
          ..add('loader', loader))
        .toString();
  }
}

class TermDataStateBuilder
    implements Builder<TermDataState, TermDataStateBuilder> {
  _$TermDataState? _$v;

  ListBuilder<int>? _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int>? ids) => _$this._ids = ids;

  MapBuilder<int, TermState>? _items;
  MapBuilder<int, TermState> get items =>
      _$this._items ??= new MapBuilder<int, TermState>();
  set items(MapBuilder<int, TermState>? items) => _$this._items = items;

  LoaderState? _loader;
  LoaderState? get loader => _$this._loader;
  set loader(LoaderState? loader) => _$this._loader = loader;

  TermDataStateBuilder();

  TermDataStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ids = $v.ids.toBuilder();
      _items = $v.items.toBuilder();
      _loader = $v.loader;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TermDataState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TermDataState;
  }

  @override
  void update(void Function(TermDataStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TermDataState build() => _build();

  _$TermDataState _build() {
    _$TermDataState _$result;
    try {
      _$result = _$v ??
          new _$TermDataState._(
              ids: ids.build(),
              items: items.build(),
              loader: BuiltValueNullFieldError.checkNotNull(
                  loader, r'TermDataState', 'loader'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TermDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
