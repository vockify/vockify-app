// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final FeatureFlagState featureFlags;
  @override
  final bool isLoading;
  @override
  final HistoryDataState history;
  @override
  final QuizDataState quiz;
  @override
  final SetDataState sets;
  @override
  final TermDataState terms;
  @override
  final HomeItem bottomNavigationItemIndex;

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (new AppStateBuilder()..update(updates))._build();

  _$AppState._(
      {required this.featureFlags,
      required this.isLoading,
      required this.history,
      required this.quiz,
      required this.sets,
      required this.terms,
      required this.bottomNavigationItemIndex})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        featureFlags, r'AppState', 'featureFlags');
    BuiltValueNullFieldError.checkNotNull(isLoading, r'AppState', 'isLoading');
    BuiltValueNullFieldError.checkNotNull(history, r'AppState', 'history');
    BuiltValueNullFieldError.checkNotNull(quiz, r'AppState', 'quiz');
    BuiltValueNullFieldError.checkNotNull(sets, r'AppState', 'sets');
    BuiltValueNullFieldError.checkNotNull(terms, r'AppState', 'terms');
    BuiltValueNullFieldError.checkNotNull(
        bottomNavigationItemIndex, r'AppState', 'bottomNavigationItemIndex');
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        featureFlags == other.featureFlags &&
        isLoading == other.isLoading &&
        history == other.history &&
        quiz == other.quiz &&
        sets == other.sets &&
        terms == other.terms &&
        bottomNavigationItemIndex == other.bottomNavigationItemIndex;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, featureFlags.hashCode);
    _$hash = $jc(_$hash, isLoading.hashCode);
    _$hash = $jc(_$hash, history.hashCode);
    _$hash = $jc(_$hash, quiz.hashCode);
    _$hash = $jc(_$hash, sets.hashCode);
    _$hash = $jc(_$hash, terms.hashCode);
    _$hash = $jc(_$hash, bottomNavigationItemIndex.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppState')
          ..add('featureFlags', featureFlags)
          ..add('isLoading', isLoading)
          ..add('history', history)
          ..add('quiz', quiz)
          ..add('sets', sets)
          ..add('terms', terms)
          ..add('bottomNavigationItemIndex', bottomNavigationItemIndex))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState? _$v;

  FeatureFlagStateBuilder? _featureFlags;
  FeatureFlagStateBuilder get featureFlags =>
      _$this._featureFlags ??= new FeatureFlagStateBuilder();
  set featureFlags(FeatureFlagStateBuilder? featureFlags) =>
      _$this._featureFlags = featureFlags;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  HistoryDataStateBuilder? _history;
  HistoryDataStateBuilder get history =>
      _$this._history ??= new HistoryDataStateBuilder();
  set history(HistoryDataStateBuilder? history) => _$this._history = history;

  QuizDataStateBuilder? _quiz;
  QuizDataStateBuilder get quiz => _$this._quiz ??= new QuizDataStateBuilder();
  set quiz(QuizDataStateBuilder? quiz) => _$this._quiz = quiz;

  SetDataStateBuilder? _sets;
  SetDataStateBuilder get sets => _$this._sets ??= new SetDataStateBuilder();
  set sets(SetDataStateBuilder? sets) => _$this._sets = sets;

  TermDataStateBuilder? _terms;
  TermDataStateBuilder get terms =>
      _$this._terms ??= new TermDataStateBuilder();
  set terms(TermDataStateBuilder? terms) => _$this._terms = terms;

  HomeItem? _bottomNavigationItemIndex;
  HomeItem? get bottomNavigationItemIndex => _$this._bottomNavigationItemIndex;
  set bottomNavigationItemIndex(HomeItem? bottomNavigationItemIndex) =>
      _$this._bottomNavigationItemIndex = bottomNavigationItemIndex;

  AppStateBuilder();

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _featureFlags = $v.featureFlags.toBuilder();
      _isLoading = $v.isLoading;
      _history = $v.history.toBuilder();
      _quiz = $v.quiz.toBuilder();
      _sets = $v.sets.toBuilder();
      _terms = $v.terms.toBuilder();
      _bottomNavigationItemIndex = $v.bottomNavigationItemIndex;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppState build() => _build();

  _$AppState _build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              featureFlags: featureFlags.build(),
              isLoading: BuiltValueNullFieldError.checkNotNull(
                  isLoading, r'AppState', 'isLoading'),
              history: history.build(),
              quiz: quiz.build(),
              sets: sets.build(),
              terms: terms.build(),
              bottomNavigationItemIndex: BuiltValueNullFieldError.checkNotNull(
                  bottomNavigationItemIndex,
                  r'AppState',
                  'bottomNavigationItemIndex'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'featureFlags';
        featureFlags.build();

        _$failedField = 'history';
        history.build();
        _$failedField = 'quiz';
        quiz.build();
        _$failedField = 'sets';
        sets.build();
        _$failedField = 'terms';
        terms.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
