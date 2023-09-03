// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeatureFlagState extends FeatureFlagState {
  @override
  final BuiltMap<FeatureFlag, bool> items;

  factory _$FeatureFlagState(
          [void Function(FeatureFlagStateBuilder)? updates]) =>
      (new FeatureFlagStateBuilder()..update(updates))._build();

  _$FeatureFlagState._({required this.items}) : super._() {
    BuiltValueNullFieldError.checkNotNull(items, r'FeatureFlagState', 'items');
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
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeatureFlagState')
          ..add('items', items))
        .toString();
  }
}

class FeatureFlagStateBuilder
    implements Builder<FeatureFlagState, FeatureFlagStateBuilder> {
  _$FeatureFlagState? _$v;

  MapBuilder<FeatureFlag, bool>? _items;
  MapBuilder<FeatureFlag, bool> get items =>
      _$this._items ??= new MapBuilder<FeatureFlag, bool>();
  set items(MapBuilder<FeatureFlag, bool>? items) => _$this._items = items;

  FeatureFlagStateBuilder();

  FeatureFlagStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeatureFlagState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FeatureFlagState;
  }

  @override
  void update(void Function(FeatureFlagStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeatureFlagState build() => _build();

  _$FeatureFlagState _build() {
    _$FeatureFlagState _$result;
    try {
      _$result = _$v ?? new _$FeatureFlagState._(items: items.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FeatureFlagState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
