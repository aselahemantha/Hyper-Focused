import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/auth/domain/repositories/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository _repository;

  GoogleLoginUseCase(this._repository);

  Future<AuthEntity> call() {
    return _repository.loginWithGoogle();
  }
}

class AppleLoginUseCase {
  final AuthRepository _repository;

  AppleLoginUseCase(this._repository);

  Future<AuthEntity> call() {
    return _repository.loginWithApple();
  }
}
