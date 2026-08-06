import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int indiceSeleccionado = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Hola Papo',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text('Angel 2026',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Te quedan disponibles:',
                    style: TextStyle(
                        fontSize: 85,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Q. 1680.00',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: 0.45,
                    minHeight: 10,
                    backgroundColor: Colors.grey[800],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.lime),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Te quedan Q.1680.00 de Q.3733.33 (45%)',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
                  ),
                ],
              ),
            ),

            // --- LOS DOS CUADRITOS ---
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TarjetaInfo(titulo: 'Cuentas', valor: 'Q7,810.00'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TarjetaInfo(titulo: 'Metas de ahorro', valor: '3 activas'),
                  ),
                ],
              ),
            ),

            // --- ÚLTIMOS MOVIMIENTOS ---
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Últimos movimientos',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text('Ver todo',
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                ],
              ),
            ),
            MovimientoItem(
              icono: Icons.directions_bus,
              colorIcono: Colors.green,
              titulo: 'Uber al trabajo',
              categoria: 'Transporte · Tarjeta',
              monto: '- Q38.00',
              cuando: 'Hoy',
            ),
            Divider(color: Colors.grey),
            MovimientoItem(
              icono: Icons.shopping_cart,
              colorIcono: Colors.lightGreen,
              titulo: 'Súper La Torre',
              categoria: 'Súper y comida · Tarjeta',
              monto: '- Q285.50',
              cuando: 'Ayer',
            ),
            Divider(color: Colors.grey),
            MovimientoItem(
              icono: Icons.arrow_upward,
              colorIcono: Colors.green,
              titulo: 'Salario quincena',
              categoria: 'Ingreso · Banco',
              monto: '+ Q4,200.00',
              cuando: 'Ayer',
            ),
          ],
        ),
      ),

      // --- BARRA DE NAVEGACIÓN ---
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        selectedIndex: indiceSeleccionado,
        onDestinationSelected: (int indice) {
          setState(() {
            indiceSeleccionado = indice;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Presupuesto',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Agregar',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Historial',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}

class TarjetaInfo extends StatelessWidget {
  final String titulo;
  final String valor;

  const TarjetaInfo({super.key, required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo,
              style: const TextStyle(fontSize: 16, color: Colors.white54)),
          const SizedBox(height: 8),
          Text(valor,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }
}

class MovimientoItem extends StatelessWidget {
  final IconData icono;
  final Color colorIcono;
  final String titulo;
  final String categoria;
  final String monto;
  final String cuando;

  const MovimientoItem({
    super.key,
    required this.icono,
    required this.colorIcono,
    required this.titulo,
    required this.categoria,
    required this.monto,
    required this.cuando,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorIcono,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icono, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 2),
                Text(categoria,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.white54)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(monto,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 2),
              Text(cuando,
                  style: const TextStyle(
                      fontSize: 14, color: Colors.white54)),
            ],
          ),
        ],
      ),
    );
  }
}