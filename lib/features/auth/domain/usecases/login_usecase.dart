import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'login_usecase.g.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<AuthEntity> call(String email, String password) {
    return _repository.login(email, password);
  }
}

// Provider will be created in the Data Layer or DI module once RepositoryImpl is ready
// For now, we can define the provider but it needs the repository provider.
