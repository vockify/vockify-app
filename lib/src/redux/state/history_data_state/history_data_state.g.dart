// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HistoryDataState extends HistoryDataState {
  @override
  final BuiltList<int> ids;
  @override
  final LoaderState loader;

  factory _$HistoryDataState(
          [void Function(HistoryDataStateBuilder)? updates]) =>
      (new HistoryDataStateBuilder()..update(updates))._build();

  _$HistoryDataState._({required this.ids, required this.loader}) : super._() {
    BuiltValueNullFieldError.checkNotNull(ids, r'HistoryDataState', 'ids');
    BuiltValueNullFieldError.checkNotNull(
        loader, r'HistoryDataState', 'loader');
  }

  @override
  HistoryDataState rebuild(void Function(HistoryDataStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HistoryDataStateBuilder toBuilder() =>
      new HistoryDataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HistoryDataState &&
        ids == other.ids &&
        loader == other.loader;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ids.hashCode);
    _$hash = $jc(_$hash, loader.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HistoryDataState')
          ..add('ids', ids)
          ..add('loader', loader))
        .toString();
  }
}

class HistoryDataStateBuilder
    implements Builder<HistoryDataState, HistoryDataStateBuilder> {
  _$HistoryDataState? _$v;

  ListBuilder<int>? _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int>? ids) => _$this._ids = ids;

  LoaderState? _loader;
  LoaderState? get loader => _$this._loader;
  set loader(LoaderState? loader) => _$this._loader = loader;

  HistoryDataStateBuilder();

  HistoryDataStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ids = $v.ids.toBuilder();
      _loader = $v.loader;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HistoryDataState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HistoryDataState;
  }

  @override
  void update(void Function(HistoryDataStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HistoryDataState build() => _build();

  _$HistoryDataState _build() {
    _$HistoryDataState _$result;
    try {
      _$result = _$v ??
          new _$HistoryDataState._(
              ids: ids.build(),
              loader: BuiltValueNullFieldError.checkNotNull(
                  loader, r'HistoryDataState', 'loader'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HistoryDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
