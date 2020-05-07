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

  factory _$QuizDataState([void Function(QuizDataStateBuilder) updates]) =>
      (new QuizDataStateBuilder()..update(updates)).build();

  _$QuizDataState._({this.ids, this.loader}) : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('QuizDataState', 'ids');
    }
    if (loader == null) {
      throw new BuiltValueNullFieldError('QuizDataState', 'loader');
    }
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
    return $jf($jc($jc(0, ids.hashCode), loader.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('QuizDataState')
          ..add('ids', ids)
          ..add('loader', loader))
        .toString();
  }
}

class QuizDataStateBuilder
    implements Builder<QuizDataState, QuizDataStateBuilder> {
  _$QuizDataState _$v;

  ListBuilder<int> _ids;
  ListBuilder<int> get ids => _$this._ids ??= new ListBuilder<int>();
  set ids(ListBuilder<int> ids) => _$this._ids = ids;

  LoaderState _loader;
  LoaderState get loader => _$this._loader;
  set loader(LoaderState loader) => _$this._loader = loader;

  QuizDataStateBuilder();

  QuizDataStateBuilder get _$this {
    if (_$v != null) {
      _ids = _$v.ids?.toBuilder();
      _loader = _$v.loader;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuizDataState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$QuizDataState;
  }

  @override
  void update(void Function(QuizDataStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$QuizDataState build() {
    _$QuizDataState _$result;
    try {
      _$result = _$v ?? new _$QuizDataState._(ids: ids.build(), loader: loader);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'QuizDataState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
