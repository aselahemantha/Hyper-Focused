import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  Future<AuthEntity> call(String email, String password, String name) {
    return _repository.signup(email, password, name);
  }
}
