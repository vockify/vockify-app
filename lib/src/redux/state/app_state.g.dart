// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final bool isAuthorized;
  @override
  final BuiltList<SetState> sets;
  @override
  final String userAvatar;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.isAuthorized, this.sets, this.userAvatar}) : super._() {
    if (isAuthorized == null) {
      throw new BuiltValueNullFieldError('AppState', 'isAuthorized');
    }
    if (sets == null) {
      throw new BuiltValueNullFieldError('AppState', 'sets');
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
        isAuthorized == other.isAuthorized &&
        sets == other.sets &&
        userAvatar == other.userAvatar;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, isAuthorized.hashCode), sets.hashCode),
        userAvatar.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('isAuthorized', isAuthorized)
          ..add('sets', sets)
          ..add('userAvatar', userAvatar))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  bool _isAuthorized;
  bool get isAuthorized => _$this._isAuthorized;
  set isAuthorized(bool isAuthorized) => _$this._isAuthorized = isAuthorized;

  ListBuilder<SetState> _sets;
  ListBuilder<SetState> get sets =>
      _$this._sets ??= new ListBuilder<SetState>();
  set sets(ListBuilder<SetState> sets) => _$this._sets = sets;

  String _userAvatar;
  String get userAvatar => _$this._userAvatar;
  set userAvatar(String userAvatar) => _$this._userAvatar = userAvatar;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _isAuthorized = _$v.isAuthorized;
      _sets = _$v.sets?.toBuilder();
      _userAvatar = _$v.userAvatar;
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
              isAuthorized: isAuthorized,
              sets: sets.build(),
              userAvatar: userAvatar);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'sets';
        sets.build();
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
