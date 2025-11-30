import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login(String email, String password);
  Future<AuthEntity> signup(String email, String password, String name);
  Future<AuthEntity> loginWithGoogle();
  Future<AuthEntity> loginWithApple();
  Future<void> logout();
}
