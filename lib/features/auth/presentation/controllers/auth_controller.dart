import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/auth/domain/usecases/login_usecase.dart';
import 'package:hyper_focused/features/auth/domain/usecases/signup_usecase.dart';
import 'package:hyper_focused/features/auth/domain/usecases/social_login_usecase.dart';
import 'package:hyper_focused/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthEntity?> build() {
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return LoginUseCase(repository).call(email, password);
    });
  }

  Future<void> signup(String email, String password, String name) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return SignupUseCase(repository).call(email, password, name);
    });
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return GoogleLoginUseCase(repository).call();
    });
  }

  Future<void> loginWithApple() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return AppleLoginUseCase(repository).call();
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.logout();
      return null;
    });
  }
}
