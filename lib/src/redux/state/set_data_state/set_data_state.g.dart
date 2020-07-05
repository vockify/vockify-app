// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetDataState extends SetDataState {
  @override
  final BuiltMap<int, SetState> items;
  @override
  final PublicSetDataState public;
  @override
  final UserSetDataState user;

  factory _$SetDataState([void Function(SetDataStateBuilder) updates]) =>
      (new SetDataStateBuilder()..update(updates)).build();

  _$SetDataState._({this.items, this.public, this.user}) : super._() {
    if (items == null) {
      throw new BuiltValueNullFieldError('SetDataState', 'items');
    }
    if (public == null) {
      throw new BuiltValueNullFieldError('SetDataState', 'public');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('SetDataState', 'user');
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
        public == other.public &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, items.hashCode), public.hashCode), user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetDataState')
          ..add('items', items)
          ..add('public', public)
          ..add('user', user))
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

  PublicSetDataStateBuilder _public;
  PublicSetDataStateBuilder get public =>
      _$this._public ??= new PublicSetDataStateBuilder();
  set public(PublicSetDataStateBuilder public) => _$this._public = public;

  UserSetDataStateBuilder _user;
  UserSetDataStateBuilder get user =>
      _$this._user ??= new UserSetDataStateBuilder();
  set user(UserSetDataStateBuilder user) => _$this._user = user;

  SetDataStateBuilder();

  SetDataStateBuilder get _$this {
    if (_$v != null) {
      _items = _$v.items?.toBuilder();
      _public = _$v.public?.toBuilder();
      _user = _$v.user?.toBuilder();
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
              items: items.build(), public: public.build(), user: user.build());
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
            'SetDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
