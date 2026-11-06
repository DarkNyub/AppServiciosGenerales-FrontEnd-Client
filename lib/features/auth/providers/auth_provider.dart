import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';

// 1. El estado sigue siendo el mismo
class AuthState {
  final bool isLoading;
  final String? error;

  AuthState({this.isLoading = false, this.error});
}

// 2. Usamos el nuevo Notifier de Riverpod 2.x
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(); // Estado inicial
  }

  Future<bool> login(String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      // Accedemos al repositorio leyendo el provider directamente
      final repository = ref.read(authRepositoryProvider);
      final success = await repository.login(email, password);

      state = AuthState(isLoading: false);
      return success;
    } catch (e) {
      state = AuthState(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }
}

// 3. Usamos NotifierProvider en lugar de StateNotifierProvider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
