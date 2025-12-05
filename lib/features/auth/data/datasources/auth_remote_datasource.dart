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
      
      final accessToken = response.data['access_token'];
      final refreshToken = response.data['refresh_token'];

      final userResponse = await _dio.get(
        '/auth/profile',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      final userData = userResponse.data;

      return {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'user': {
          'id': userData['id'].toString(),
          'email': userData['email'],
          'name': userData['name'],
          'photoUrl': userData['avatar'],
        },
      };
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

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post('/auth/refresh-token', data: {
        'refreshToken': refreshToken,
      });
      
      final accessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      final userResponse = await _dio.get(
        '/auth/profile',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      final userData = userResponse.data;

      return {
        'accessToken': accessToken,
        'refreshToken': newRefreshToken ?? refreshToken,
        'user': {
          'id': userData['id'].toString(),
          'email': userData['email'],
          'name': userData['name'],
          'photoUrl': userData['avatar'],
        },
      };
    } catch (e) {
      rethrow;
    }
  }
}
