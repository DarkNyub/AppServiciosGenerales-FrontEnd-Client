import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/storage/secure_storage_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(dioProvider), ref.read(tokenStorageProvider));
});

class AuthRepository {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  AuthRepository(this._dio, this._tokenStorage);

  Future<bool> login(String email, String password) async {
    try {
      // El BaseUrl ya tiene "/api", así que solo agregamos la ruta del controlador
      final response = await _dio.post(
        '/Autenticacion/login',
        data: {'email': email, 'password': password},
      );

      final data = response.data;
      final token = data['token']; // Extraemos el token del DTO enriquecido

      if (token != null) {
        // Guardamos el token de forma encriptada localmente
        await _tokenStorage.saveToken(token);
        return true;
      }
      return false;
    } on DioException catch (e) {
      // Extraemos el mensaje de error exacto que envía nuestro backend en .NET
      final mensajeError =
          e.response?.data['mensaje'] ?? 'Error de conexión al iniciar sesión';
      throw Exception(mensajeError);
    }
  }
}
