// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_data_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QuizDataState extends QuizDataState {
  @override
  final BuiltList<int> ids;
  @override
  final LoaderState loader;

  factory _$QuizDataState([void Function(QuizDataStateBuilder)? updates]) =>
      (new QuizDataStateBuilder()..update(updates))._build();

  _$QuizDataState._({required this.ids, required this.loader}) : super._() {
    BuiltValueNullFieldError.checkNotNull(ids, r'QuizDataState', 'ids');
    BuiltValueNullFieldError.checkNotNull(loader, r'QuizDataState', 'loader');
  }

  @override
  QuizDataState rebuild(void Function(QuizDataStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuizDataStateBuilder toBuilder() => new QuizDataStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizDataState && ids == other.ids && loader == other.loader;
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
    return (newBuiltValueToStringHelper(r'QuizDataState')
          ..add('ids', ids)
          ..add('loader', loader))
        .toString();
  }
}

class QuizDataStateBuilder
    implements Builder<QuizDataState, QuizDataStateBuilder> {
  _$QuizDataState? _$v;

  ListBuilder<int>? _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int>? ids) => _$this._ids = ids;

  LoaderState? _loader;
  LoaderState? get loader => _$this._loader;
  set loader(LoaderState? loader) => _$this._loader = loader;

  QuizDataStateBuilder();

  QuizDataStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ids = $v.ids.toBuilder();
      _loader = $v.loader;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuizDataState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$QuizDataState;
  }

  @override
  void update(void Function(QuizDataStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QuizDataState build() => _build();

  _$QuizDataState _build() {
    _$QuizDataState _$result;
    try {
      _$result = _$v ??
          new _$QuizDataState._(
              ids: ids.build(),
              loader: BuiltValueNullFieldError.checkNotNull(
                  loader, r'QuizDataState', 'loader'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'QuizDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
