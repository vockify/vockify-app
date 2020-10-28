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
  final String lastAddedTerm;
  @override
  final LoaderState loader;

  factory _$TermDataState([void Function(TermDataStateBuilder) updates]) =>
      (new TermDataStateBuilder()..update(updates)).build();

  _$TermDataState._({this.ids, this.items, this.lastAddedTerm, this.loader})
      : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'ids');
    }
    if (items == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'items');
    }
    if (lastAddedTerm == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'lastAddedTerm');
    }
    if (loader == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'loader');
    }
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
        lastAddedTerm == other.lastAddedTerm &&
        loader == other.loader;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, ids.hashCode), items.hashCode), lastAddedTerm.hashCode),
        loader.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TermDataState')
          ..add('ids', ids)
          ..add('items', items)
          ..add('lastAddedTerm', lastAddedTerm)
          ..add('loader', loader))
        .toString();
  }
}

class TermDataStateBuilder
    implements Builder<TermDataState, TermDataStateBuilder> {
  _$TermDataState _$v;

  ListBuilder<int> _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int> ids) => _$this._ids = ids;

  MapBuilder<int, TermState> _items;
  MapBuilder<int, TermState> get items =>
      _$this._items ??= new MapBuilder<int, TermState>();
  set items(MapBuilder<int, TermState> items) => _$this._items = items;

  String _lastAddedTerm;
  String get lastAddedTerm => _$this._lastAddedTerm;
  set lastAddedTerm(String lastAddedTerm) =>
      _$this._lastAddedTerm = lastAddedTerm;

  LoaderState _loader;
  LoaderState get loader => _$this._loader;
  set loader(LoaderState loader) => _$this._loader = loader;

  TermDataStateBuilder();

  TermDataStateBuilder get _$this {
    if (_$v != null) {
      _ids = _$v.ids?.toBuilder();
      _items = _$v.items?.toBuilder();
      _lastAddedTerm = _$v.lastAddedTerm;
      _loader = _$v.loader;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TermDataState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TermDataState;
  }

  @override
  void update(void Function(TermDataStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TermDataState build() {
    _$TermDataState _$result;
    try {
      _$result = _$v ??
          new _$TermDataState._(
              ids: ids.build(),
              items: items.build(),
              lastAddedTerm: lastAddedTerm,
              loader: loader);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TermDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
