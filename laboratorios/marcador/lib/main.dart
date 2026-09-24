import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marcador',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const Marcador(),
    );
  }
}

class Marcador extends StatefulWidget {
  const Marcador({super.key});

  @override
  State<Marcador> createState() => _MarcadorState();
}

class _MarcadorState extends State<Marcador> {
  String equipoA = 'Equipo A';
  String equipoB = 'Equipo B';
  int puntosA = 0;
  int puntosB = 0;

  // el mensaje sale de comparar los puntos
  String mensaje() {
    if (puntosA > puntosB) return 'Va ganando $equipoA';
    if (puntosB > puntosA) return 'Va ganando $equipoB';
    return 'Empate';
  }

  void reiniciar() {
    setState(() {
      puntosA = 0;
      puntosB = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcador deportivo'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: tarjetaEquipo(
                    equipoA,
                    puntosA,
                    puntosA > puntosB,
                    () {
                      setState(() {
                        puntosA++;
                      });
                    },
                    () {
                      // no dejar que baje de cero
                      if (puntosA > 0) {
                        setState(() {
                          puntosA--;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: tarjetaEquipo(
                    equipoB,
                    puntosB,
                    puntosB > puntosA,
                    () {
                      setState(() {
                        puntosB++;
                      });
                    },
                    () {
                      if (puntosB > 0) {
                        setState(() {
                          puntosB--;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              mensaje(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: reiniciar,
              icon: const Icon(Icons.refresh),
              label: const Text('Reiniciar'),
            ),
          ],
        ),
      ),
    );
  }

  // tarjeta de cada equipo, se pone verde si va ganando
  Widget tarjetaEquipo(String nombre, int puntos, bool ganando,
      VoidCallback sumar, VoidCallback restar) {
    Color colorTexto = ganando ? Colors.white : Colors.black87;

    return Card(
      color: ganando ? Colors.green : Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              nombre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorTexto,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$puntos',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: colorTexto,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: restar,
                    child: const Text('-1'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: sumar,
                    child: const Text('+1'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}