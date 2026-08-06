import 'package:flutter/material.dart';

void main() {
  runApp(const NotiBrainApp());
}

class NotiBrainApp extends StatelessWidget {
  const NotiBrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotiBrain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NotiBrain',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: const TabBarPlaceholder(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Recent Courses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(
                  child: CourseCard(
                    nombre: 'Mate II',
                    progreso: 1.0,
                    porcentaje: '100%',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CourseCard(
                    nombre: 'Física I',
                    progreso: 0.6,
                    porcentaje: '60%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Aquí luego navegaremos a la pantalla de nuevo tema
                },
                icon: const Icon(Icons.add),
                label: const Text('Nuevo tema'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String nombre;
  final double progreso;
  final String porcentaje;

  const CourseCard({
    super.key,
    required this.nombre,
    required this.progreso,
    required this.porcentaje,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              nombre,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progreso,
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 8),
            Text(porcentaje),
          ],
        ),
      ),
    );
  }
}

class TabBarPlaceholder extends StatelessWidget
    implements PreferredSizeWidget {
  const TabBarPlaceholder({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text('Cursos', style: TextStyle(fontSize: 14)),
          Text('Retro', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}