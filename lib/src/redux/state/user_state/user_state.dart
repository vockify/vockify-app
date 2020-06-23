import 'package:built_value/built_value.dart';
import 'package:vockify/src/api/dto/user_dto.dart';

part 'user_state.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {
  factory UserState([void updates(UserStateBuilder b)]) = _$UserState;

  factory UserState.fromDto(UserDto userDto) => UserState((builder) {
        builder
          ..email = userDto.email
          ..firstName = userDto.firstName
          ..lastName = userDto.lastName
          ..avatar = userDto.avatar;
      });

  factory UserState.initial({int selectedSetId}) => UserState((builder) {
        builder
          ..email = ''
          ..firstName = ''
          ..lastName = ''
          ..selectedSetId = selectedSetId;
      });

  UserState._();

  @nullable
  String get avatar;

  String get email;

  String get firstName;

  String get lastName;

  @nullable
  int get selectedSetId;
}
