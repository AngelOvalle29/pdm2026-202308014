import 'package:flutter/material.dart';

import '../models/producto.dart';
import '../utils/formato.dart';
import '../widgets/producto_pedido.dart';

/// Pantalla principal "Mi pedido".
///
/// Es StatefulWidget porque las cantidades cambian. Todo el estado
/// (las cantidades) vive aquí y se modifica únicamente con setState.
class MiPedidoScreen extends StatefulWidget {
  const MiPedidoScreen({super.key});

  @override
  State<MiPedidoScreen> createState() => _MiPedidoScreenState();
}

class _MiPedidoScreenState extends State<MiPedidoScreen> {
  /// Menú fijo de la cafetería.
  static const List<Producto> _productos = [
    Producto(nombre: 'Café', precio: 10.00),
    Producto(nombre: 'Sándwich', precio: 25.00),
    Producto(nombre: 'Jugo', precio: 12.00),
  ];

  /// Cantidad pedida de cada producto (mismo índice que _productos).
  /// Todas inician en cero.
  final List<int> _cantidades = List<int>.filled(_productos.length, 0);

  /// Total = suma de (precio × cantidad) de cada producto.
  /// Es un getter: se recalcula en cada build, así que siempre
  /// refleja las cantidades actuales después de cada setState.
  double get _total {
    double total = 0;
    for (int i = 0; i < _productos.length; i++) {
      total += _productos[i].precio * _cantidades[i];
    }
    return total;
  }

  void _incrementar(int indice) {
    setState(() {
      _cantidades[indice]++;
    });
  }

  void _decrementar(int indice) {
    // Doble protección: además de deshabilitar el botón en la UI,
    // la lógica nunca permite bajar de cero.
    if (_cantidades[indice] == 0) return;
    setState(() {
      _cantidades[indice]--;
    });
  }

  void _vaciarPedido() {
    setState(() {
      for (int i = 0; i < _cantidades.length; i++) {
        _cantidades[i] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi pedido'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Lista de productos: siempre visibles, aunque su cantidad sea 0
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: _productos.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final producto = _productos[index];
                return ProductoPedido(
                  nombre: producto.nombre,
                  precio: producto.precio,
                  cantidad: _cantidades[index],
                  onIncrementar: () => _incrementar(index),
                  onDecrementar: () => _decrementar(index),
                );
              },
            ),
          ),

          // Pie: total + botón Vaciar pedido
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        formatoQuetzales(_total),
                        key: const Key('total'),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      key: const Key('vaciar_pedido'),
                      onPressed: _vaciarPedido,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Vaciar pedido'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}