import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hyper_focused/features/auth/data/repositories/auth_repository_impl.dart';

part 'signup_usecase.g.dart';

@riverpod
SignupUseCase signupUseCase(SignupUseCaseRef ref) {
  return SignupUseCase(ref.read(authRepositoryProvider));
}

class SignupUseCase {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  Future<AuthEntity> call(String email, String password, String name) {
    return _repository.signup(email, password, name);
  }
}
