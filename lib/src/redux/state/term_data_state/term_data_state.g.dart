// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TermDataState extends TermDataState {
  @override
  final TermState added;
  @override
  final BuiltList<int> ids;
  @override
  final bool isLoaded;
  @override
  final BuiltMap<int, TermState> items;

  factory _$TermDataState([void Function(TermDataStateBuilder) updates]) =>
      (new TermDataStateBuilder()..update(updates)).build();

  _$TermDataState._({this.added, this.ids, this.isLoaded, this.items})
      : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'ids');
    }
    if (isLoaded == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'isLoaded');
    }
    if (items == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'items');
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
        added == other.added &&
        ids == other.ids &&
        isLoaded == other.isLoaded &&
        items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, added.hashCode), ids.hashCode), isLoaded.hashCode),
        items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TermDataState')
          ..add('added', added)
          ..add('ids', ids)
          ..add('isLoaded', isLoaded)
          ..add('items', items))
        .toString();
  }
}

class TermDataStateBuilder
    implements Builder<TermDataState, TermDataStateBuilder> {
  _$TermDataState _$v;

  TermStateBuilder _added;
  TermStateBuilder get added => _$this._added ??= new TermStateBuilder();
  set added(TermStateBuilder added) => _$this._added = added;

  ListBuilder<int> _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int> ids) => _$this._ids = ids;

  bool _isLoaded;
  bool get isLoaded => _$this._isLoaded;
  set isLoaded(bool isLoaded) => _$this._isLoaded = isLoaded;

  MapBuilder<int, TermState> _items;
  MapBuilder<int, TermState> get items =>
      _$this._items ??= new MapBuilder<int, TermState>();
  set items(MapBuilder<int, TermState> items) => _$this._items = items;

  TermDataStateBuilder();

  TermDataStateBuilder get _$this {
    if (_$v != null) {
      _added = _$v.added?.toBuilder();
      _ids = _$v.ids?.toBuilder();
      _isLoaded = _$v.isLoaded;
      _items = _$v.items?.toBuilder();
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
              added: _added?.build(),
              ids: ids.build(),
              isLoaded: isLoaded,
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
            'TermDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
