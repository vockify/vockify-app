// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TermState extends TermState {
  @override
  final int id;
  @override
  final String name;
  @override
  final String definition;

  factory _$TermState([void Function(TermStateBuilder) updates]) =>
      (new TermStateBuilder()..update(updates)).build();

  _$TermState._({this.id, this.name, this.definition}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TermState', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TermState', 'name');
    }
    if (definition == null) {
      throw new BuiltValueNullFieldError('TermState', 'definition');
    }
  }

  @override
  TermState rebuild(void Function(TermStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TermStateBuilder toBuilder() => new TermStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermState &&
        id == other.id &&
        name == other.name &&
        definition == other.definition;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, id.hashCode), name.hashCode), definition.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TermState')
          ..add('id', id)
          ..add('name', name)
          ..add('definition', definition))
        .toString();
  }
}

class TermStateBuilder implements Builder<TermState, TermStateBuilder> {
  _$TermState _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _definition;
  String get definition => _$this._definition;
  set definition(String definition) => _$this._definition = definition;

  TermStateBuilder();

  TermStateBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _definition = _$v.definition;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TermState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TermState;
  }

  @override
  void update(void Function(TermStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TermState build() {
    final _$result =
        _$v ?? new _$TermState._(id: id, name: name, definition: definition);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
