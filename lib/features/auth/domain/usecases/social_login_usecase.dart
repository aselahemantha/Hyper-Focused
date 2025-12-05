import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hyper_focused/features/auth/data/repositories/auth_repository_impl.dart';

part 'social_login_usecase.g.dart';

@riverpod
GoogleLoginUseCase googleLoginUseCase(Ref ref) {
  return GoogleLoginUseCase(ref.read(authRepositoryProvider));
}

@riverpod
AppleLoginUseCase appleLoginUseCase(Ref ref) {
  return AppleLoginUseCase(ref.read(authRepositoryProvider));
}

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
