/// Formatea un monto en quetzales con dos decimales.
///
/// Ejemplos: 0 -> "Q0.00", 57 -> "Q57.00", 12.5 -> "Q12.50".
String formatoQuetzales(double monto) => 'Q${monto.toStringAsFixed(2)}';