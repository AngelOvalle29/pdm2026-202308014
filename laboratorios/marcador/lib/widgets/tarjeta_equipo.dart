import 'package:flutter/material.dart';

/// Verde usado para destacar al equipo que va ganando.
const Color kColorGanador = Color(0xFF2E7D32);

/// Tarjeta de un equipo: nombre, puntos y botones −1 / +1.
///
/// Es un widget sin estado propio: recibe los datos y avisa al padre
/// mediante callbacks. El estado vive únicamente en `MarcadorScreen`.
class TarjetaEquipo extends StatelessWidget {
  const TarjetaEquipo({
    super.key,
    required this.id,
    required this.nombre,
    required this.puntos,
    required this.esGanador,
    required this.onSumar,
    required this.onRestar,
  });

  /// Identificador corto ('a' o 'b') usado en las keys para las pruebas.
  final String id;
  final String nombre;
  final int puntos;
  final bool esGanador;
  final VoidCallback onSumar;
  final VoidCallback onRestar;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final colorFondo =
        esGanador ? kColorGanador : scheme.surfaceContainerHighest;
    final colorTexto = esGanador ? Colors.white : scheme.onSurface;

    return AnimatedContainer(
      key: Key('tarjeta_$id'),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorFondo,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: esGanador ? kColorGanador : scheme.outlineVariant,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (esGanador) ...[
                const Icon(Icons.emoji_events, color: Colors.amberAccent),
                const SizedBox(width: 4),
              ],
              Flexible(
                child: Text(
                  nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorTexto,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            child: Text(
              '$puntos',
              key: Key('puntos_$id'),
              style: textTheme.displayLarge?.copyWith(
                color: colorTexto,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  key: Key('restar_$id'),
                  // Deshabilitado en 0 como refuerzo visual del límite.
                  onPressed: puntos > 0 ? onRestar : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorTexto,
                    side: BorderSide(color: colorTexto.withAlpha(150)),
                  ),
                  child: const Text('−1', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  key: Key('sumar_$id'),
                  onPressed: onSumar,
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        esGanador ? Colors.white : scheme.primary,
                    foregroundColor:
                        esGanador ? kColorGanador : scheme.onPrimary,
                  ),
                  child: const Text('+1', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}