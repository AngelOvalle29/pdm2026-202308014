import 'package:flutter/material.dart';

import '../widgets/tarjeta_equipo.dart';

/// Pantalla principal del marcador.
///
/// Es un [StatefulWidget] porque los puntos cambian con las acciones del
/// usuario. El ganador, el mensaje y los colores NO se guardan como estado:
/// se calculan en cada `build` a partir de los puntos, así nunca quedan
/// desincronizados.
class MarcadorScreen extends StatefulWidget {
  const MarcadorScreen({super.key});

  @override
  State<MarcadorScreen> createState() => _MarcadorScreenState();
}

class _MarcadorScreenState extends State<MarcadorScreen> {
  static const String _nombreA = 'Equipo A';
  static const String _nombreB = 'Equipo B';

  int _puntosA = 0;
  int _puntosB = 0;

  // ---------------------------------------------------------------------------
  // Acciones (cada una modifica solo los puntos de su equipo)
  // ---------------------------------------------------------------------------

  void _sumarA() => setState(() => _puntosA++);

  void _sumarB() => setState(() => _puntosB++);

  void _restarA() {
    if (_puntosA == 0) return; // Límite inferior: nunca negativo.
    setState(() => _puntosA--);
  }

  void _restarB() {
    if (_puntosB == 0) return; // Límite inferior: nunca negativo.
    setState(() => _puntosB--);
  }

  void _reiniciar() {
    setState(() {
      _puntosA = 0;
      _puntosB = 0;
    });
  }

  // ---------------------------------------------------------------------------
  // Valores derivados del estado
  // ---------------------------------------------------------------------------

  /// Nombre del equipo que va ganando, o `null` si hay empate.
  String? get _ganador {
    if (_puntosA > _puntosB) return _nombreA;
    if (_puntosB > _puntosA) return _nombreB;
    return null;
  }

  String get _mensaje => _ganador == null ? 'Empate' : 'Va ganando $_ganador';

  // ---------------------------------------------------------------------------
  // Interfaz
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final hayGanador = _ganador != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcador deportivo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TarjetaEquipo(
                          id: 'a',
                          nombre: _nombreA,
                          puntos: _puntosA,
                          esGanador: _ganador == _nombreA,
                          onSumar: _sumarA,
                          onRestar: _restarA,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'vs',
                          style: textTheme.titleMedium?.copyWith(
                            color: scheme.outline,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TarjetaEquipo(
                          id: 'b',
                          nombre: _nombreB,
                          puntos: _puntosB,
                          esGanador: _ganador == _nombreB,
                          onSumar: _sumarB,
                          onRestar: _restarB,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          hayGanador ? Icons.trending_up : Icons.balance,
                          color: hayGanador ? kColorGanador : scheme.outline,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            _mensaje,
                            key: const Key('mensaje'),
                            textAlign: TextAlign.center,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.tonalIcon(
                    key: const Key('reiniciar'),
                    onPressed: _reiniciar,
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reiniciar'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}