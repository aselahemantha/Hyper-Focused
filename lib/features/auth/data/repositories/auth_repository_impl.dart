import 'package:hyper_focused/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/auth/domain/repositories/auth_repository.dart';
import 'package:hyper_focused/core/storage/token_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'auth_repository_impl.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(tokenStorageProvider),
  );
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  AuthRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  @override
  Future<AuthEntity> login(String email, String password) async {
    final data = await _remoteDataSource.login(email, password);
    final authEntity = AuthEntity.fromJson(data);
    await _saveTokens(authEntity);
    return authEntity;
  }

  @override
  Future<AuthEntity> signup(String email, String password, String name) async {
    final data = await _remoteDataSource.signup(email, password, name);
    final authEntity = AuthEntity.fromJson(data);
    await _saveTokens(authEntity);
    return authEntity;
  }

  @override
  Future<AuthEntity> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google Sign In aborted');
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final data = await _remoteDataSource.loginWithGoogle(googleAuth.idToken!);
    final authEntity = AuthEntity.fromJson(data);
    await _saveTokens(authEntity);
    return authEntity;
  }

  @override
  Future<AuthEntity> loginWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    
    final data = await _remoteDataSource.loginWithApple(
      credential.identityToken!,
      credential.authorizationCode, // Using auth code as nonce placeholder or actual logic needed
    );
    final authEntity = AuthEntity.fromJson(data);
    await _saveTokens(authEntity);
    return authEntity;
  }

  @override
  Future<AuthEntity> refreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }
    final data = await _remoteDataSource.refreshToken(refreshToken);
    final authEntity = AuthEntity.fromJson(data);
    await _saveTokens(authEntity);
    return authEntity;
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.clearTokens();
    await _googleSignIn.signOut();
  }

  Future<void> _saveTokens(AuthEntity authEntity) async {
    await _tokenStorage.saveAccessToken(authEntity.accessToken);
    await _tokenStorage.saveRefreshToken(authEntity.refreshToken);
  }
}
