// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetState extends SetState {
  @override
  final String icon;
  @override
  final int id;
  @override
  final String name;
  @override
  final int parentId;
  @override
  final String type;
  @override
  final SetTermsState terms;

  factory _$SetState([void Function(SetStateBuilder) updates]) =>
      (new SetStateBuilder()..update(updates)).build();

  _$SetState._(
      {this.icon, this.id, this.name, this.parentId, this.type, this.terms})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('SetState', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SetState', 'name');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('SetState', 'type');
    }
    if (terms == null) {
      throw new BuiltValueNullFieldError('SetState', 'terms');
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
        icon == other.icon &&
        id == other.id &&
        name == other.name &&
        parentId == other.parentId &&
        type == other.type &&
        terms == other.terms;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, icon.hashCode), id.hashCode), name.hashCode),
                parentId.hashCode),
            type.hashCode),
        terms.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetState')
          ..add('icon', icon)
          ..add('id', id)
          ..add('name', name)
          ..add('parentId', parentId)
          ..add('type', type)
          ..add('terms', terms))
        .toString();
  }
}

class SetStateBuilder implements Builder<SetState, SetStateBuilder> {
  _$SetState _$v;

  String _icon;
  String get icon => _$this._icon;
  set icon(String icon) => _$this._icon = icon;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _parentId;
  int get parentId => _$this._parentId;
  set parentId(int parentId) => _$this._parentId = parentId;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  SetTermsStateBuilder _terms;
  SetTermsStateBuilder get terms =>
      _$this._terms ??= new SetTermsStateBuilder();
  set terms(SetTermsStateBuilder terms) => _$this._terms = terms;

  SetStateBuilder();

  SetStateBuilder get _$this {
    if (_$v != null) {
      _icon = _$v.icon;
      _id = _$v.id;
      _name = _$v.name;
      _parentId = _$v.parentId;
      _type = _$v.type;
      _terms = _$v.terms?.toBuilder();
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
    _$SetState _$result;
    try {
      _$result = _$v ??
          new _$SetState._(
              icon: icon,
              id: id,
              name: name,
              parentId: parentId,
              type: type,
              terms: terms.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'terms';
        terms.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SetState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
