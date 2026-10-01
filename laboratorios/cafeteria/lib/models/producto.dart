/// Representa un producto del menú de la cafetería.
///
/// Es inmutable: el nombre y el precio no cambian. La cantidad pedida
/// NO vive aquí, sino en el estado de la pantalla (MiPedidoScreen).
class Producto {
  const Producto({
    required this.nombre,
    required this.precio,
  });

  final String nombre;
  final double precio;
}