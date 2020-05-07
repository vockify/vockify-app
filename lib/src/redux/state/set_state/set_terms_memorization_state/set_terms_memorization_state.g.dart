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
          [void Function(SetTermsMemorizationStateBuilder) updates]) =>
      (new SetTermsMemorizationStateBuilder()..update(updates)).build();

  _$SetTermsMemorizationState._({this.bad, this.good, this.great}) : super._() {
    if (bad == null) {
      throw new BuiltValueNullFieldError('SetTermsMemorizationState', 'bad');
    }
    if (good == null) {
      throw new BuiltValueNullFieldError('SetTermsMemorizationState', 'good');
    }
    if (great == null) {
      throw new BuiltValueNullFieldError('SetTermsMemorizationState', 'great');
    }
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
    return $jf($jc($jc($jc(0, bad.hashCode), good.hashCode), great.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetTermsMemorizationState')
          ..add('bad', bad)
          ..add('good', good)
          ..add('great', great))
        .toString();
  }
}

class SetTermsMemorizationStateBuilder
    implements
        Builder<SetTermsMemorizationState, SetTermsMemorizationStateBuilder> {
  _$SetTermsMemorizationState _$v;

  int _bad;
  int get bad => _$this._bad;
  set bad(int bad) => _$this._bad = bad;

  int _good;
  int get good => _$this._good;
  set good(int good) => _$this._good = good;

  int _great;
  int get great => _$this._great;
  set great(int great) => _$this._great = great;

  SetTermsMemorizationStateBuilder();

  SetTermsMemorizationStateBuilder get _$this {
    if (_$v != null) {
      _bad = _$v.bad;
      _good = _$v.good;
      _great = _$v.great;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetTermsMemorizationState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SetTermsMemorizationState;
  }

  @override
  void update(void Function(SetTermsMemorizationStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SetTermsMemorizationState build() {
    final _$result = _$v ??
        new _$SetTermsMemorizationState._(bad: bad, good: good, great: great);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
