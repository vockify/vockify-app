// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_terms_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetTermsState extends SetTermsState {
  @override
  final int count;
  @override
  final SetTermsMemorizationState memorization;

  factory _$SetTermsState([void Function(SetTermsStateBuilder) updates]) =>
      (new SetTermsStateBuilder()..update(updates)).build();

  _$SetTermsState._({this.count, this.memorization}) : super._() {
    if (count == null) {
      throw new BuiltValueNullFieldError('SetTermsState', 'count');
    }
    if (memorization == null) {
      throw new BuiltValueNullFieldError('SetTermsState', 'memorization');
    }
  }

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
    return $jf($jc($jc(0, count.hashCode), memorization.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetTermsState')
          ..add('count', count)
          ..add('memorization', memorization))
        .toString();
  }
}

class SetTermsStateBuilder
    implements Builder<SetTermsState, SetTermsStateBuilder> {
  _$SetTermsState _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  SetTermsMemorizationStateBuilder _memorization;
  SetTermsMemorizationStateBuilder get memorization =>
      _$this._memorization ??= new SetTermsMemorizationStateBuilder();
  set memorization(SetTermsMemorizationStateBuilder memorization) =>
      _$this._memorization = memorization;

  SetTermsStateBuilder();

  SetTermsStateBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _memorization = _$v.memorization?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetTermsState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SetTermsState;
  }

  @override
  void update(void Function(SetTermsStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SetTermsState build() {
    _$SetTermsState _$result;
    try {
      _$result = _$v ??
          new _$SetTermsState._(
              count: count, memorization: memorization.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'memorization';
        memorization.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SetTermsState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
