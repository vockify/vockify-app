// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserState extends UserState {
  @override
  final int id;
  @override
  final String avatar;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final bool isRegistered;

  factory _$UserState([void Function(UserStateBuilder) updates]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._(
      {this.id,
      this.avatar,
      this.email,
      this.firstName,
      this.lastName,
      this.isRegistered})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('UserState', 'id');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('UserState', 'email');
    }
    if (isRegistered == null) {
      throw new BuiltValueNullFieldError('UserState', 'isRegistered');
    }
  }

  @override
  UserState rebuild(void Function(UserStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStateBuilder toBuilder() => new UserStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserState &&
        id == other.id &&
        avatar == other.avatar &&
        email == other.email &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        isRegistered == other.isRegistered;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), avatar.hashCode), email.hashCode),
                firstName.hashCode),
            lastName.hashCode),
        isRegistered.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('id', id)
          ..add('avatar', avatar)
          ..add('email', email)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('isRegistered', isRegistered))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _avatar;
  String get avatar => _$this._avatar;
  set avatar(String avatar) => _$this._avatar = avatar;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  bool _isRegistered;
  bool get isRegistered => _$this._isRegistered;
  set isRegistered(bool isRegistered) => _$this._isRegistered = isRegistered;

  UserStateBuilder();

  UserStateBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _avatar = _$v.avatar;
      _email = _$v.email;
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _isRegistered = _$v.isRegistered;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserState;
  }

  @override
  void update(void Function(UserStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserState build() {
    final _$result = _$v ??
        new _$UserState._(
            id: id,
            avatar: avatar,
            email: email,
            firstName: firstName,
            lastName: lastName,
            isRegistered: isRegistered);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
