class CartItem {
  final String id;
  final String nombre;
  final int cantidad;
  final double precio;
  final String fecha;

  CartItem(
      {required this.id,
      required this.nombre,
      required this.cantidad,
      required this.precio,
      required this.fecha});
}
