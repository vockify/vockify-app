// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TermDataState extends TermDataState {
  @override
  final PublicTermDataState public;
  @override
  final UserTermDataState user;
  @override
  final BuiltMap<int, TermState> items;

  factory _$TermDataState([void Function(TermDataStateBuilder) updates]) =>
      (new TermDataStateBuilder()..update(updates)).build();

  _$TermDataState._({this.public, this.user, this.items}) : super._() {
    if (public == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'public');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('TermDataState', 'user');
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
        public == other.public &&
        user == other.user &&
        items == other.items;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, public.hashCode), user.hashCode), items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TermDataState')
          ..add('public', public)
          ..add('user', user)
          ..add('items', items))
        .toString();
  }
}

class TermDataStateBuilder
    implements Builder<TermDataState, TermDataStateBuilder> {
  _$TermDataState _$v;

  PublicTermDataStateBuilder _public;
  PublicTermDataStateBuilder get public =>
      _$this._public ??= new PublicTermDataStateBuilder();
  set public(PublicTermDataStateBuilder public) => _$this._public = public;

  UserTermDataStateBuilder _user;
  UserTermDataStateBuilder get user =>
      _$this._user ??= new UserTermDataStateBuilder();
  set user(UserTermDataStateBuilder user) => _$this._user = user;

  MapBuilder<int, TermState> _items;
  MapBuilder<int, TermState> get items =>
      _$this._items ??= new MapBuilder<int, TermState>();
  set items(MapBuilder<int, TermState> items) => _$this._items = items;

  TermDataStateBuilder();

  TermDataStateBuilder get _$this {
    if (_$v != null) {
      _public = _$v.public?.toBuilder();
      _user = _$v.user?.toBuilder();
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
              public: public.build(), user: user.build(), items: items.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'public';
        public.build();
        _$failedField = 'user';
        user.build();
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
