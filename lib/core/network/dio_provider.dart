import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/environment.dart';
import '../storage/secure_storage_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  final tokenStorage = ref.read(tokenStorageProvider);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Antes de cada petición, leemos el token y lo agregamos al header
        final token = await tokenStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // Manejo global de errores (ej. Token expirado = 401)
        if (e.response?.statusCode == 401) {
          tokenStorage.deleteToken();
          // Aquí podríamos forzar la redirección al login
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
});
