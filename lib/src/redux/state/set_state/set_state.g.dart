// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetState extends SetState {
  @override
  final String? icon;
  @override
  final int id;
  @override
  final String name;
  @override
  final int? parentId;
  @override
  final int userId;
  @override
  final SetTermsState terms;

  factory _$SetState([void Function(SetStateBuilder)? updates]) =>
      (new SetStateBuilder()..update(updates))._build();

  _$SetState._(
      {this.icon,
      required this.id,
      required this.name,
      this.parentId,
      required this.userId,
      required this.terms})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'SetState', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'SetState', 'name');
    BuiltValueNullFieldError.checkNotNull(userId, r'SetState', 'userId');
    BuiltValueNullFieldError.checkNotNull(terms, r'SetState', 'terms');
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
        userId == other.userId &&
        terms == other.terms;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, terms.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetState')
          ..add('icon', icon)
          ..add('id', id)
          ..add('name', name)
          ..add('parentId', parentId)
          ..add('userId', userId)
          ..add('terms', terms))
        .toString();
  }
}

class SetStateBuilder implements Builder<SetState, SetStateBuilder> {
  _$SetState? _$v;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _parentId;
  int? get parentId => _$this._parentId;
  set parentId(int? parentId) => _$this._parentId = parentId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  SetTermsStateBuilder? _terms;
  SetTermsStateBuilder get terms =>
      _$this._terms ??= new SetTermsStateBuilder();
  set terms(SetTermsStateBuilder? terms) => _$this._terms = terms;

  SetStateBuilder();

  SetStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _icon = $v.icon;
      _id = $v.id;
      _name = $v.name;
      _parentId = $v.parentId;
      _userId = $v.userId;
      _terms = $v.terms.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SetState;
  }

  @override
  void update(void Function(SetStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetState build() => _build();

  _$SetState _build() {
    _$SetState _$result;
    try {
      _$result = _$v ??
          new _$SetState._(
              icon: icon,
              id: BuiltValueNullFieldError.checkNotNull(id, r'SetState', 'id'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'SetState', 'name'),
              parentId: parentId,
              userId: BuiltValueNullFieldError.checkNotNull(
                  userId, r'SetState', 'userId'),
              terms: terms.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'terms';
        terms.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SetState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
