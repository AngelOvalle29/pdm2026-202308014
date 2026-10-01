import 'package:flutter/material.dart';

import 'screens/mi_pedido_screen.dart';

void main() {
  runApp(const CafeteriaApp());
}

class CafeteriaApp extends StatelessWidget {
  const CafeteriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi pedido',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6D4C41), // tono café
      ),
      home: const MiPedidoScreen(),
    );
  }
}