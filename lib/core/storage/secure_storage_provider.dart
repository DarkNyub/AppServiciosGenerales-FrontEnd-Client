import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

class TokenStorage {
  final FlutterSecureStorage _storage;

  TokenStorage(this._storage);

  Future<void> saveToken(String token) async =>
      await _storage.write(key: 'jwt_token', value: token);
  Future<String?> getToken() async => await _storage.read(key: 'jwt_token');
  Future<void> deleteToken() async => await _storage.delete(key: 'jwt_token');
}

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage(ref.read(secureStorageProvider));
});
