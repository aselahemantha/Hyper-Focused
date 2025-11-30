import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hyper_focused/core/storage/token_storage.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.hyperfocused.com', // TODO: Replace with actual API URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final tokenStorage = ref.read(tokenStorageProvider);
        final token = await tokenStorage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        // TODO: Implement token refresh logic here if needed
        return handler.next(e);
      },
    ),
  );

  return dio;
}
