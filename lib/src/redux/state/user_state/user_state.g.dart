// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserState extends UserState {
  @override
  final int id;
  @override
  final String? avatar;
  @override
  final String email;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final bool isRegistered;

  factory _$UserState([void Function(UserStateBuilder)? updates]) =>
      (new UserStateBuilder()..update(updates))._build();

  _$UserState._(
      {required this.id,
      this.avatar,
      required this.email,
      this.firstName,
      this.lastName,
      required this.isRegistered})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UserState', 'id');
    BuiltValueNullFieldError.checkNotNull(email, r'UserState', 'email');
    BuiltValueNullFieldError.checkNotNull(
        isRegistered, r'UserState', 'isRegistered');
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
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, isRegistered.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserState')
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
  _$UserState? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  bool? _isRegistered;
  bool? get isRegistered => _$this._isRegistered;
  set isRegistered(bool? isRegistered) => _$this._isRegistered = isRegistered;

  UserStateBuilder();

  UserStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _avatar = $v.avatar;
      _email = $v.email;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _isRegistered = $v.isRegistered;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserState;
  }

  @override
  void update(void Function(UserStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserState build() => _build();

  _$UserState _build() {
    final _$result = _$v ??
        new _$UserState._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'UserState', 'id'),
            avatar: avatar,
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'UserState', 'email'),
            firstName: firstName,
            lastName: lastName,
            isRegistered: BuiltValueNullFieldError.checkNotNull(
                isRegistered, r'UserState', 'isRegistered'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
