// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TermState extends TermState {
  @override
  final String definition;
  @override
  final int id;
  @override
  final String name;
  @override
  final int setId;
  @override
  final MemorizationLevel? memorizationLevel;

  factory _$TermState([void Function(TermStateBuilder)? updates]) =>
      (new TermStateBuilder()..update(updates))._build();

  _$TermState._(
      {required this.definition,
      required this.id,
      required this.name,
      required this.setId,
      this.memorizationLevel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        definition, r'TermState', 'definition');
    BuiltValueNullFieldError.checkNotNull(id, r'TermState', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'TermState', 'name');
    BuiltValueNullFieldError.checkNotNull(setId, r'TermState', 'setId');
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
        definition == other.definition &&
        id == other.id &&
        name == other.name &&
        setId == other.setId &&
        memorizationLevel == other.memorizationLevel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, definition.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, setId.hashCode);
    _$hash = $jc(_$hash, memorizationLevel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TermState')
          ..add('definition', definition)
          ..add('id', id)
          ..add('name', name)
          ..add('setId', setId)
          ..add('memorizationLevel', memorizationLevel))
        .toString();
  }
}

class TermStateBuilder implements Builder<TermState, TermStateBuilder> {
  _$TermState? _$v;

  String? _definition;
  String? get definition => _$this._definition;
  set definition(String? definition) => _$this._definition = definition;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _setId;
  int? get setId => _$this._setId;
  set setId(int? setId) => _$this._setId = setId;

  MemorizationLevel? _memorizationLevel;
  MemorizationLevel? get memorizationLevel => _$this._memorizationLevel;
  set memorizationLevel(MemorizationLevel? memorizationLevel) =>
      _$this._memorizationLevel = memorizationLevel;

  TermStateBuilder();

  TermStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _definition = $v.definition;
      _id = $v.id;
      _name = $v.name;
      _setId = $v.setId;
      _memorizationLevel = $v.memorizationLevel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TermState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TermState;
  }

  @override
  void update(void Function(TermStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TermState build() => _build();

  _$TermState _build() {
    final _$result = _$v ??
        new _$TermState._(
            definition: BuiltValueNullFieldError.checkNotNull(
                definition, r'TermState', 'definition'),
            id: BuiltValueNullFieldError.checkNotNull(id, r'TermState', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'TermState', 'name'),
            setId: BuiltValueNullFieldError.checkNotNull(
                setId, r'TermState', 'setId'),
            memorizationLevel: memorizationLevel);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
