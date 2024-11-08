import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DTO {
  static const String BACKEND_API = 'https://carcareapi.elitesx.work/api';
  
  final Dio api = Dio(BaseOptions(baseUrl: BACKEND_API));
  final _secureStorage = const FlutterSecureStorage();

  Future<void> auth()async {
    api.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          if (error.response != null) {
            print("Error data: ${error.response?.data}");
            print("Error status: ${error.response?.statusCode}");
          } else {
            print("No response received: ${error.requestOptions}");
          }
          return handler.next(error); // Pass the error to the next interceptor
        },
      ),
    );
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'accessToken', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'accessToken');
  }

  Future<void> deleteToken() async {
    try {
      await _secureStorage.delete(key: 'accessToken');
    } catch (error) {
      print("Failed to delete token: $error");
    }
  }
}
