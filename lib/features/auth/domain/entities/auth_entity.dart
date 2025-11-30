import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_entity.freezed.dart';
part 'auth_entity.g.dart';

@freezed
class AuthEntity with _$AuthEntity {
  const factory AuthEntity({
    required String accessToken,
    required String refreshToken,
    required UserEntity user,
  }) = _AuthEntity;

  factory AuthEntity.fromJson(Map<String, dynamic> json) => _$AuthEntityFromJson(json);
}

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    String? name,
    String? photoUrl,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
