import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hyper_focused/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
import 'auth_remote_datasource_test.mocks.dart';

void main() {
  late AuthRemoteDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = AuthRemoteDataSource(mockDio);
  });

  final tUserResponse = {
    'id': 1,
    'email': 'test@mail.com',
    'name': 'Test User',
    'avatar': 'https://example.com/avatar.png',
  };

  final tExpectedUserMap = {
    'id': '1',
    'email': 'test@mail.com',
    'name': 'Test User',
    'photoUrl': 'https://example.com/avatar.png',
  };

  group('login', () {
    const tEmail = 'test@mail.com';
    const tPassword = 'password';
    final tLoginResponse = {'access_token': 'access_token', 'refresh_token': 'refresh_token'};

    test('should perform login and fetch profile', () async {
      // arrange
      when(mockDio.post('/auth/login', data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: tLoginResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: '/auth/login'),
        ),
      );
      when(mockDio.get('/auth/profile', options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: tUserResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/profile'),
        ),
      );

      // act
      final result = await dataSource.login(tEmail, tPassword);

      // assert
      verify(mockDio.post('/auth/login', data: {'email': tEmail, 'password': tPassword}));
      verify(mockDio.get('/auth/profile', options: anyNamed('options')));
      
      expect(result['accessToken'], 'access_token');
      expect(result['refreshToken'], 'refresh_token');
      expect(result['user'], tExpectedUserMap);
    });
  });

  group('refreshToken', () {
    const tRefreshToken = 'test_refresh_token';
    final tRefreshResponse = {'access_token': 'new_access_token', 'refresh_token': 'new_refresh_token'};

    test('should perform refresh and fetch profile', () async {
      // arrange
      when(mockDio.post('/auth/refresh-token', data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          data: tRefreshResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/refresh-token'),
        ),
      );
      when(mockDio.get('/auth/profile', options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          data: tUserResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/profile'),
        ),
      );

      // act
      final result = await dataSource.refreshToken(tRefreshToken);

      // assert
      verify(mockDio.post('/auth/refresh-token', data: {'refreshToken': tRefreshToken}));
      verify(mockDio.get('/auth/profile', options: anyNamed('options')));

      expect(result['accessToken'], 'new_access_token');
      expect(result['refreshToken'], 'new_refresh_token');
      expect(result['user'], tExpectedUserMap);
    });
  });
}
