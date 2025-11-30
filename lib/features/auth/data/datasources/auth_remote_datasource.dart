import 'package:dio/dio.dart';
import 'package:hyper_focused/core/network/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_datasource.g.dart';

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSource(ref.read(dioProvider));
}

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signup(String email, String password, String name) async {
    try {
      final response = await _dio.post('/auth/signup', data: {
        'email': email,
        'password': password,
        'name': name,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> loginWithGoogle(String idToken) async {
    try {
      final response = await _dio.post('/auth/google', data: {
        'idToken': idToken,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> loginWithApple(String idToken, String nonce) async {
    try {
      final response = await _dio.post('/auth/apple', data: {
        'idToken': idToken,
        'nonce': nonce,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
