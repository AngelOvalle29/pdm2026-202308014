import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cafeteria/main.dart';
import 'package:cafeteria/widgets/producto_pedido.dart';

// ---------- Helpers ----------

String textoTotal(WidgetTester tester) =>
    tester.widget<Text>(find.byKey(const Key('total'))).data!;

int cantidadDe(WidgetTester tester, String nombre) => int.parse(
      tester.widget<Text>(find.byKey(Key('cantidad_$nombre'))).data!,
    );

Future<void> tocar(WidgetTester tester, String key, {int veces = 1}) async {
  for (int i = 0; i < veces; i++) {
    await tester.tap(find.byKey(Key(key)));
    await tester.pump();
  }
}

Future<void> armarPedidoQ57(WidgetTester tester) async {
  await tocar(tester, 'incrementar_Café', veces: 2);
  await tocar(tester, 'incrementar_Sándwich');
  await tocar(tester, 'incrementar_Jugo');
}

// ---------- Pruebas obligatorias del laboratorio ----------

void main() {
  testWidgets('La pantalla se titula "Mi pedido" y usa ProductoPedido 3 veces',
      (tester) async {
    await tester.pumpWidget(const CafeteriaApp());

    expect(find.text('Mi pedido'), findsWidgets);
    expect(find.byType(ProductoPedido), findsNWidgets(3));
    expect(find.text('Q10.00 c/u'), findsOneWidget);
    expect(find.text('Q25.00 c/u'), findsOneWidget);
    expect(find.text('Q12.00 c/u'), findsOneWidget);
  });

  testWidgets('Prueba 1: al iniciar, cantidades en 0 y total Q0.00',
      (tester) async {
    await tester.pumpWidget(const CafeteriaApp());

    expect(cantidadDe(tester, 'Café'), 0);
    expect(cantidadDe(tester, 'Sándwich'), 0);
    expect(cantidadDe(tester, 'Jugo'), 0);
    expect(textoTotal(tester), 'Q0.00');
  });

  testWidgets('Prueba 2: 2 cafés, 1 sándwich y 1 jugo = Q57.00',
      (tester) async {
    await tester.pumpWidget(const CafeteriaApp());
    await armarPedidoQ57(tester);

    expect(cantidadDe(tester, 'Café'), 2);
    expect(cantidadDe(tester, 'Sándwich'), 1);
    expect(cantidadDe(tester, 'Jugo'), 1);
    expect(textoTotal(tester), 'Q57.00');
  });

  testWidgets('Prueba 3: quitar 1 café deja el total en Q47.00',
      (tester) async {
    await tester.pumpWidget(const CafeteriaApp());
    await armarPedidoQ57(tester);
    await tocar(tester, 'decrementar_Café');

    expect(cantidadDe(tester, 'Café'), 1);
    expect(textoTotal(tester), 'Q47.00');
  });

  testWidgets('Prueba 4: restar en cero no cambia cantidad ni total',
      (tester) async {
    await tester.pumpWidget(const CafeteriaApp());
    await tocar(tester, 'incrementar_Café');
    await tocar(tester, 'decrementar_Jugo'); // Jugo está en 0

    expect(cantidadDe(tester, 'Jugo'), 0);
    expect(cantidadDe(tester, 'Café'), 1);
    expect(textoTotal(tester), 'Q10.00');
    // El producto sigue visible aunque su cantidad sea cero
    expect(find.text('Jugo'), findsOneWidget);
  });

  testWidgets('Prueba 5: Vaciar pedido regresa todo a 0 y total Q0.00',
      (tester) async {
    await tester.pumpWidget(const CafeteriaApp());
    await armarPedidoQ57(tester);
    await tocar(tester, 'vaciar_pedido');

    expect(cantidadDe(tester, 'Café'), 0);
    expect(cantidadDe(tester, 'Sándwich'), 0);
    expect(cantidadDe(tester, 'Jugo'), 0);
    expect(textoTotal(tester), 'Q0.00');
    expect(find.byType(ProductoPedido), findsNWidgets(3));
  });
}