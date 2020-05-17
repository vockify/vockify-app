// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetState extends SetState {
  @override
  final int id;
  @override
  final String name;
  @override
  final String icon;
  @override
  final int termsCount;

  factory _$SetState([void Function(SetStateBuilder) updates]) =>
      (new SetStateBuilder()..update(updates)).build();

  _$SetState._({this.id, this.name, this.icon, this.termsCount}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('SetState', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SetState', 'name');
    }
    if (icon == null) {
      throw new BuiltValueNullFieldError('SetState', 'icon');
    }
    if (termsCount == null) {
      throw new BuiltValueNullFieldError('SetState', 'termsCount');
    }
  }

  @override
  SetState rebuild(void Function(SetStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetStateBuilder toBuilder() => new SetStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetState &&
        id == other.id &&
        name == other.name &&
        icon == other.icon &&
        termsCount == other.termsCount;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, id.hashCode), name.hashCode), icon.hashCode),
        termsCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetState')
          ..add('id', id)
          ..add('name', name)
          ..add('icon', icon)
          ..add('termsCount', termsCount))
        .toString();
  }
}

class SetStateBuilder implements Builder<SetState, SetStateBuilder> {
  _$SetState _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _icon;
  String get icon => _$this._icon;
  set icon(String icon) => _$this._icon = icon;

  int _termsCount;
  int get termsCount => _$this._termsCount;
  set termsCount(int termsCount) => _$this._termsCount = termsCount;

  SetStateBuilder();

  SetStateBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _icon = _$v.icon;
      _termsCount = _$v.termsCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SetState;
  }

  @override
  void update(void Function(SetStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SetState build() {
    final _$result = _$v ??
        new _$SetState._(
            id: id, name: name, icon: icon, termsCount: termsCount);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
