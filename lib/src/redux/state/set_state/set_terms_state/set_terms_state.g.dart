// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_terms_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetTermsState extends SetTermsState {
  @override
  final int? count;
  @override
  final SetTermsMemorizationState? memorization;

  factory _$SetTermsState([void Function(SetTermsStateBuilder)? updates]) =>
      (new SetTermsStateBuilder()..update(updates))._build();

  _$SetTermsState._({this.count, this.memorization}) : super._();

  @override
  SetTermsState rebuild(void Function(SetTermsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetTermsStateBuilder toBuilder() => new SetTermsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetTermsState &&
        count == other.count &&
        memorization == other.memorization;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, memorization.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetTermsState')
          ..add('count', count)
          ..add('memorization', memorization))
        .toString();
  }
}

class SetTermsStateBuilder
    implements Builder<SetTermsState, SetTermsStateBuilder> {
  _$SetTermsState? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  SetTermsMemorizationStateBuilder? _memorization;
  SetTermsMemorizationStateBuilder get memorization =>
      _$this._memorization ??= new SetTermsMemorizationStateBuilder();
  set memorization(SetTermsMemorizationStateBuilder? memorization) =>
      _$this._memorization = memorization;

  SetTermsStateBuilder();

  SetTermsStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _memorization = $v.memorization?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetTermsState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SetTermsState;
  }

  @override
  void update(void Function(SetTermsStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetTermsState build() => _build();

  _$SetTermsState _build() {
    _$SetTermsState _$result;
    try {
      _$result = _$v ??
          new _$SetTermsState._(
              count: count, memorization: _memorization?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'memorization';
        _memorization?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SetTermsState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
