// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TermDataState extends TermDataState {
  @override
  final BuiltMap<int, TermState> items;
  @override
  final PublicTermDataState public;
  @override
  final UserTermDataState user;
  @override
  final String lastAddedTerm;

  factory _$TermDataState([void Function(TermDataStateBuilder) updates]) =>
      (new TermDataStateBuilder()..update(updates)).build();

  _$TermDataState._({this.items, this.public, this.user, this.lastAddedTerm})
      : super._() {
    if (items == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'items');
    }
    if (public == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'public');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'user');
    }
    if (lastAddedTerm == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'lastAddedTerm');
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
        items == other.items &&
        public == other.public &&
        user == other.user &&
        lastAddedTerm == other.lastAddedTerm;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, items.hashCode), public.hashCode), user.hashCode),
        lastAddedTerm.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TermDataState')
          ..add('items', items)
          ..add('public', public)
          ..add('user', user)
          ..add('lastAddedTerm', lastAddedTerm))
        .toString();
  }
}

class TermDataStateBuilder
    implements Builder<TermDataState, TermDataStateBuilder> {
  _$TermDataState _$v;

  MapBuilder<int, TermState> _items;
  MapBuilder<int, TermState> get items =>
      _$this._items ??= new MapBuilder<int, TermState>();
  set items(MapBuilder<int, TermState> items) => _$this._items = items;

  PublicTermDataStateBuilder _public;
  PublicTermDataStateBuilder get public =>
      _$this._public ??= new PublicTermDataStateBuilder();
  set public(PublicTermDataStateBuilder public) => _$this._public = public;

  UserTermDataStateBuilder _user;
  UserTermDataStateBuilder get user =>
      _$this._user ??= new UserTermDataStateBuilder();
  set user(UserTermDataStateBuilder user) => _$this._user = user;

  String _lastAddedTerm;
  String get lastAddedTerm => _$this._lastAddedTerm;
  set lastAddedTerm(String lastAddedTerm) =>
      _$this._lastAddedTerm = lastAddedTerm;

  TermDataStateBuilder();

  TermDataStateBuilder get _$this {
    if (_$v != null) {
      _items = _$v.items?.toBuilder();
      _public = _$v.public?.toBuilder();
      _user = _$v.user?.toBuilder();
      _lastAddedTerm = _$v.lastAddedTerm;
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
              items: items.build(),
              public: public.build(),
              user: user.build(),
              lastAddedTerm: lastAddedTerm);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'public';
        public.build();
        _$failedField = 'user';
        user.build();
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
