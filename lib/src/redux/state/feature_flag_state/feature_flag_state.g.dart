// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeatureFlagState extends FeatureFlagState {
  @override
  final BuiltMap<FeatureFlag, bool> items;

  factory _$FeatureFlagState(
          [void Function(FeatureFlagStateBuilder) updates]) =>
      (new FeatureFlagStateBuilder()..update(updates)).build();

  _$FeatureFlagState._({this.items}) : super._() {
    if (items == null) {
      throw new BuiltValueNullFieldError('FeatureFlagState', 'items');
    }
  }

  @override
  FeatureFlagState rebuild(void Function(FeatureFlagStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeatureFlagStateBuilder toBuilder() =>
      new FeatureFlagStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeatureFlagState && items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(0, items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeatureFlagState')
          ..add('items', items))
        .toString();
  }
}

class FeatureFlagStateBuilder
    implements Builder<FeatureFlagState, FeatureFlagStateBuilder> {
  _$FeatureFlagState _$v;

  MapBuilder<FeatureFlag, bool> _items;
  MapBuilder<FeatureFlag, bool> get items =>
      _$this._items ??= new MapBuilder<FeatureFlag, bool>();
  set items(MapBuilder<FeatureFlag, bool> items) => _$this._items = items;

  FeatureFlagStateBuilder();

  FeatureFlagStateBuilder get _$this {
    if (_$v != null) {
      _items = _$v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeatureFlagState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FeatureFlagState;
  }

  @override
  void update(void Function(FeatureFlagStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FeatureFlagState build() {
    _$FeatureFlagState _$result;
    try {
      _$result = _$v ?? new _$FeatureFlagState._(items: items.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FeatureFlagState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
