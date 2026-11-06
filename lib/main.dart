import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cliente/core/router/app_router.dart'; // Importación absoluta segura

void main() {
  runApp(
    // ProviderScope es obligatorio para que Riverpod funcione
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Aquí lee el provider importado desde app_router.dart
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'App Cliente - Servicios',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
