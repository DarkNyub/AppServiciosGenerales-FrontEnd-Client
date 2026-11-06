import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/ui/login_screen.dart'; // Importamos la UI real

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            const LoginScreen(), // Renderizamos la pantalla aquí
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Catálogo de Servicios - BIENVENIDO')),
        ),
      ),
    ],
  );
});
