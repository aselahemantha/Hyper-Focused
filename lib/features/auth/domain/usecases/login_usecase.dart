import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/auth/domain/repositories/auth_repository.dart';
import 'package:hyper_focused/features/auth/data/repositories/auth_repository_impl.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_usecase.g.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<AuthEntity> call(String email, String password) {
    return _repository.login(email, password);
  }
}

@riverpod
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
}
