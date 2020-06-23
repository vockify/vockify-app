// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final String currentRoute;
  @override
  final bool isAuthorized;
  @override
  final bool isLoading;
  @override
  final SetDataState sets;
  @override
  final TermDataState terms;
  @override
  final QuizDataState quiz;
  @override
  final UserState user;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.currentRoute,
      this.isAuthorized,
      this.isLoading,
      this.sets,
      this.terms,
      this.quiz,
      this.user})
      : super._() {
    if (isAuthorized == null) {
      throw new BuiltValueNullFieldError('AppState', 'isAuthorized');
    }
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('AppState', 'isLoading');
    }
    if (sets == null) {
      throw new BuiltValueNullFieldError('AppState', 'sets');
    }
    if (terms == null) {
      throw new BuiltValueNullFieldError('AppState', 'terms');
    }
    if (quiz == null) {
      throw new BuiltValueNullFieldError('AppState', 'quiz');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('AppState', 'user');
    }
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
        currentRoute == other.currentRoute &&
        isAuthorized == other.isAuthorized &&
        isLoading == other.isLoading &&
        sets == other.sets &&
        terms == other.terms &&
        quiz == other.quiz &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc(0, currentRoute.hashCode),
                            isAuthorized.hashCode),
                        isLoading.hashCode),
                    sets.hashCode),
                terms.hashCode),
            quiz.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('currentRoute', currentRoute)
          ..add('isAuthorized', isAuthorized)
          ..add('isLoading', isLoading)
          ..add('sets', sets)
          ..add('terms', terms)
          ..add('quiz', quiz)
          ..add('user', user))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  String _currentRoute;
  String get currentRoute => _$this._currentRoute;
  set currentRoute(String currentRoute) => _$this._currentRoute = currentRoute;

  bool _isAuthorized;
  bool get isAuthorized => _$this._isAuthorized;
  set isAuthorized(bool isAuthorized) => _$this._isAuthorized = isAuthorized;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  SetDataStateBuilder _sets;
  SetDataStateBuilder get sets => _$this._sets ??= new SetDataStateBuilder();
  set sets(SetDataStateBuilder sets) => _$this._sets = sets;

  TermDataStateBuilder _terms;
  TermDataStateBuilder get terms =>
      _$this._terms ??= new TermDataStateBuilder();
  set terms(TermDataStateBuilder terms) => _$this._terms = terms;

  QuizDataStateBuilder _quiz;
  QuizDataStateBuilder get quiz => _$this._quiz ??= new QuizDataStateBuilder();
  set quiz(QuizDataStateBuilder quiz) => _$this._quiz = quiz;

  UserStateBuilder _user;
  UserStateBuilder get user => _$this._user ??= new UserStateBuilder();
  set user(UserStateBuilder user) => _$this._user = user;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _currentRoute = _$v.currentRoute;
      _isAuthorized = _$v.isAuthorized;
      _isLoading = _$v.isLoading;
      _sets = _$v.sets?.toBuilder();
      _terms = _$v.terms?.toBuilder();
      _quiz = _$v.quiz?.toBuilder();
      _user = _$v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              currentRoute: currentRoute,
              isAuthorized: isAuthorized,
              isLoading: isLoading,
              sets: sets.build(),
              terms: terms.build(),
              quiz: quiz.build(),
              user: user.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'sets';
        sets.build();
        _$failedField = 'terms';
        terms.build();
        _$failedField = 'quiz';
        quiz.build();
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
