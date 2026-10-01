# Laboratorio: Mi pedido de cafetería

**Curso:** Programación de Dispositivos Móviles, Sección E
**Docente:** Saúl Calderón
**Estudiante:** Angel Glicerio Ovalle Fernández
**Carné:** 202308014

Aplicación en Flutter que permite armar un pedido de cafetería con tres productos
(Café Q10.00, Sándwich Q25.00 y Jugo Q12.00), ajustar cantidades con los controles
**-1 / cantidad / +1**, ver el total en quetzales y vaciar el pedido.

## Captura: pedido de Q57.00

2 cafés + 1 sándwich + 1 jugo = **Q57.00**


## Estructura del proyecto

```
lib/
├── main.dart                     # Punto de entrada y tema de la app
├── models/
│   └── producto.dart             # Modelo inmutable: nombre y precio
├── screens/
│   └── mi_pedido_screen.dart     # Pantalla "Mi pedido" (StatefulWidget + setState)
├── utils/
│   └── formato.dart              # Formato en quetzales con dos decimales
└── widgets/
    └── producto_pedido.dart      # Widget reutilizable ProductoPedido
test/
└── widget_test.dart              # Pruebas automatizadas de los 5 casos obligatorios
```

## Cómo ejecutar

```bash
flutter pub get
flutter run -d linux     # o -d chrome / un dispositivo Android
flutter test             # ejecuta las pruebas obligatorias
```

## Pruebas obligatorias

| # | Caso | Resultado esperado | Estado |
|---|------|--------------------|--------|
| 1 | Al iniciar | Cantidades en 0 y total Q0.00 | ✅ |
| 2 | 2 cafés, 1 sándwich, 1 jugo | Total Q57.00 | ✅ |
| 3 | Quitar 1 café | Total Q47.00 | ✅ |
| 4 | Restar a un producto en cero | Cantidad y total no cambian | ✅ |
| 5 | Vaciar pedido | Cantidades en 0 y total Q0.00 | ✅ |

Las cinco pruebas están automatizadas en `test/widget_test.dart`.

## Preguntas

### ¿Cómo calcula el total?

Las cantidades se guardan en el estado de `MiPedidoScreen` (una lista con un entero
por producto). El total se obtiene con un *getter* que recorre los productos y suma
**precio × cantidad** de cada uno:

```dart
double get _total {
  double total = 0;
  for (int i = 0; i < _productos.length; i++) {
    total += _productos[i].precio * _cantidades[i];
  }
  return total;
}
```

Cada vez que se presiona +1, -1 o *Vaciar pedido*, la cantidad se modifica dentro de
`setState`. Eso hace que Flutter vuelva a ejecutar `build`, y como el total es un getter
se recalcula al instante con las cantidades actuales. No se guarda el total en una
variable aparte, así nunca puede quedar desincronizado. Finalmente se muestra con
`toStringAsFixed(2)` precedido de "Q" (por ejemplo, `Q57.00`). Para impedir negativos,
el botón -1 se deshabilita cuando la cantidad es 0 y además la lógica de `_decrementar`
no hace nada si la cantidad ya es cero.

### ¿Por qué conviene reutilizar ProductoPedido?

- **Evita duplicar código:** las tres filas se construyen con el mismo widget, cambiando
  solo los parámetros (nombre, precio, cantidad y acciones).
- **Consistencia visual:** todas las filas tienen la misma distribución, espacios y
  controles; un cambio de diseño se hace en un solo lugar y se refleja en todas.
- **Mantenimiento y escalabilidad:** agregar un cuarto producto solo requiere añadirlo a
  la lista, sin escribir otra fila desde cero.
- **Separación de responsabilidades:** `ProductoPedido` es un `StatelessWidget` que solo
  se encarga de *mostrar* y avisar con callbacks (`onIncrementar`, `onDecrementar`);
  el estado y la lógica viven en la pantalla padre. Esto lo hace más fácil de probar y
  de reutilizar en otras pantallas.
