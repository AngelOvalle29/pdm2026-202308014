import 'package:flutter/material.dart';

import '../utils/formato.dart';

/// Fila reutilizable que muestra un producto del pedido:
/// nombre, precio unitario y los controles -1 / cantidad / +1.
///
/// Es un StatelessWidget: no guarda estado propio. Recibe los datos
/// (nombre, precio, cantidad) y las acciones de los botones
/// (onIncrementar, onDecrementar) como parámetros. El estado real
/// vive en la pantalla padre, que llama a setState.
class ProductoPedido extends StatelessWidget {
  const ProductoPedido({
    super.key,
    required this.nombre,
    required this.precio,
    required this.cantidad,
    required this.onIncrementar,
    required this.onDecrementar,
  });

  final String nombre;
  final double precio;
  final int cantidad;
  final VoidCallback onIncrementar;
  final VoidCallback onDecrementar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          // Nombre y precio unitario
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatoQuetzales(precio)} c/u',
                  key: Key('precio_$nombre'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Controles -1 / cantidad / +1
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  key: Key('decrementar_$nombre'),
                  tooltip: 'Quitar 1',
                  icon: const Icon(Icons.remove),
                  // Deshabilitado en cero: impide valores negativos
                  onPressed: cantidad > 0 ? onDecrementar : null,
                ),
                SizedBox(
                  width: 32,
                  child: Text(
                    '$cantidad',
                    key: Key('cantidad_$nombre'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  key: Key('incrementar_$nombre'),
                  tooltip: 'Agregar 1',
                  icon: const Icon(Icons.add),
                  onPressed: onIncrementar,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}