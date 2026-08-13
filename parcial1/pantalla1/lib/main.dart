import 'package:flutter/material.dart';

void main() {
  runApp(const InkashApp());
}

class InkashApp extends StatelessWidget {
  const InkashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inkash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5FA83C)),
        scaffoldBackgroundColor: const Color(0xFFF4F5F0),
      ),
      home: const PantallaInicio(),
    );
  }
}

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  int _indiceNav = 0;
  bool _saldoVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _construirEncabezado(),
            const SizedBox(height: 24),
            _construirTarjetaSaldo(),
            const SizedBox(height: 20),
            _construirAccesosRapidos(),
            const SizedBox(height: 28),
            _construirTituloSeccion('Tus tarjetas', accion: '+ Nueva'),
            const SizedBox(height: 14),
            _construirListaTarjetas(),
            const SizedBox(height: 28),
            _construirTituloSeccion('Transacciones', accion: 'Ver todas'),
            const SizedBox(height: 12),
            const ItemTransaccion(
              icono: Icons.local_cafe,
              titulo: 'Starbucks Coffee',
              fecha: '17 de octubre, 09:00 PM',
              monto: '- Q44.80',
            ),
            const SizedBox(height: 12),
            const ItemTransaccion(
              icono: Icons.shopping_bag,
              titulo: 'Super la Torre',
              fecha: '16 de octubre, 05:20 PM',
              monto: '- Q285.50',
            ),
            const SizedBox(height: 12),
            const ItemTransaccion(
              icono: Icons.arrow_upward,
              titulo: 'Depósito de salariior',
              fecha: '15 de octubre, 08:00 AM',
              monto: '+ Q4,200.00',
              esIngreso: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceNav,
        onDestinationSelected: (indice) {
          setState(() => _indiceNav = indice);
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Inicio'),
          NavigationDestination(
              icon: Icon(Icons.pie_chart_outline),
              selectedIcon: Icon(Icons.pie_chart),
              label: 'Resumen'),
          NavigationDestination(
              icon: Icon(Icons.swap_horiz_outlined),
              selectedIcon: Icon(Icons.swap_horiz),
              label: 'Transferir'),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _construirEncabezado() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFF5FA83C),
              child: Text('H',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Buenos días',
                    style: TextStyle(fontSize: 13, color: Colors.black54)),
                Text('Angel',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }

  // Tarjeta grande con el saldo y el botón de agregar adentro
  Widget _construirTarjetaSaldo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE3E5DD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo disponible',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              GestureDetector(
                onTap: () => setState(() => _saldoVisible = !_saldoVisible),
                child: Icon(
                  _saldoVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black38,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _saldoVisible ? 'Q 3,200.00' : 'Q ••••••',
            style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF5FA83C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3E6E28),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFF5FA83C)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward),
                  label: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Fila de accesos rápidos con chips redondos
  Widget _construirAccesosRapidos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _AccesoRapido(icono: Icons.phone_android, etiqueta: 'Recargas'),
        _AccesoRapido(icono: Icons.receipt_long, etiqueta: 'Servicios'),
        _AccesoRapido(icono: Icons.savings, etiqueta: 'Ahorros'),
        _AccesoRapido(icono: Icons.qr_code_scanner, etiqueta: 'Escanear'),
      ],
    );
  }

  Widget _construirTituloSeccion(String titulo, {required String accion}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(accion,
            style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3E6E28),
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _construirListaTarjetas() {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          TarjetaBancaria(
            colorInicio: Color(0xFF6FB63C),
            colorFin: Color(0xFF3E6E28),
            tipo: 'Tarjeta de débito',
            numero: '•••• 4568',
          ),
          SizedBox(width: 16),
          TarjetaBancaria(
            colorInicio: Color(0xFF4A4A4A),
            colorFin: Color(0xFF212121),
            tipo: 'Tarjeta de crédito',
            numero: '•••• 2478',
          ),
        ],
      ),
    );
  }
}

// Chip de acceso rápido (ícono en círculo + texto)
class _AccesoRapido extends StatelessWidget {
  final IconData icono;
  final String etiqueta;

  const _AccesoRapido({required this.icono, required this.etiqueta});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE3E5DD)),
          ),
          child: Icon(icono, color: const Color(0xFF3E6E28)),
        ),
        const SizedBox(height: 8),
        Text(etiqueta,
            style: const TextStyle(fontSize: 12, color: Colors.black87)),
      ],
    );
  }
}

// Tarjeta bancaria vertical con degradado
class TarjetaBancaria extends StatelessWidget {
  final Color colorInicio;
  final Color colorFin;
  final String tipo;
  final String numero;

  const TarjetaBancaria({
    super.key,
    required this.colorInicio,
    required this.colorFin,
    required this.tipo,
    required this.numero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorInicio, colorFin],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Inkash',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const Icon(Icons.credit_card, color: Colors.white70),
            ],
          ),
          const Icon(Icons.contactless, color: Colors.white70, size: 26),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(numero,
                  style: const TextStyle(
                      fontSize: 20, letterSpacing: 2, color: Colors.white)),
              const SizedBox(height: 6),
              Text(tipo,
                  style:
                      const TextStyle(fontSize: 13, color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }
}

// Renglón de transacción, ahora dentro de una Card
class ItemTransaccion extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String fecha;
  final String monto;
  final bool esIngreso;

  const ItemTransaccion({
    super.key,
    required this.icono,
    required this.titulo,
    required this.fecha,
    required this.monto,
    this.esIngreso = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE3E5DD)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2E8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icono, color: const Color(0xFF3E6E28)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 3),
                  Text(fecha,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
            Text(
              monto,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: esIngreso
                    ? const Color(0xFF3E6E28)
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}