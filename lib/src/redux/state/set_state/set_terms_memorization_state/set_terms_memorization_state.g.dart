// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_terms_memorization_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetTermsMemorizationState extends SetTermsMemorizationState {
  @override
  final int bad;
  @override
  final int good;
  @override
  final int great;

  factory _$SetTermsMemorizationState(
          [void Function(SetTermsMemorizationStateBuilder)? updates]) =>
      (new SetTermsMemorizationStateBuilder()..update(updates))._build();

  _$SetTermsMemorizationState._(
      {required this.bad, required this.good, required this.great})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        bad, r'SetTermsMemorizationState', 'bad');
    BuiltValueNullFieldError.checkNotNull(
        good, r'SetTermsMemorizationState', 'good');
    BuiltValueNullFieldError.checkNotNull(
        great, r'SetTermsMemorizationState', 'great');
  }

  @override
  SetTermsMemorizationState rebuild(
          void Function(SetTermsMemorizationStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetTermsMemorizationStateBuilder toBuilder() =>
      new SetTermsMemorizationStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetTermsMemorizationState &&
        bad == other.bad &&
        good == other.good &&
        great == other.great;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bad.hashCode);
    _$hash = $jc(_$hash, good.hashCode);
    _$hash = $jc(_$hash, great.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetTermsMemorizationState')
          ..add('bad', bad)
          ..add('good', good)
          ..add('great', great))
        .toString();
  }
}

class SetTermsMemorizationStateBuilder
    implements
        Builder<SetTermsMemorizationState, SetTermsMemorizationStateBuilder> {
  _$SetTermsMemorizationState? _$v;

  int? _bad;
  int? get bad => _$this._bad;
  set bad(int? bad) => _$this._bad = bad;

  int? _good;
  int? get good => _$this._good;
  set good(int? good) => _$this._good = good;

  int? _great;
  int? get great => _$this._great;
  set great(int? great) => _$this._great = great;

  SetTermsMemorizationStateBuilder();

  SetTermsMemorizationStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bad = $v.bad;
      _good = $v.good;
      _great = $v.great;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetTermsMemorizationState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SetTermsMemorizationState;
  }

  @override
  void update(void Function(SetTermsMemorizationStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetTermsMemorizationState build() => _build();

  _$SetTermsMemorizationState _build() {
    final _$result = _$v ??
        new _$SetTermsMemorizationState._(
            bad: BuiltValueNullFieldError.checkNotNull(
                bad, r'SetTermsMemorizationState', 'bad'),
            good: BuiltValueNullFieldError.checkNotNull(
                good, r'SetTermsMemorizationState', 'good'),
            great: BuiltValueNullFieldError.checkNotNull(
                great, r'SetTermsMemorizationState', 'great'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
