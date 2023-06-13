class Ventas {
  final double total;
  final String nombre;
  final String fecha;
  final int cantidad;
  final double precio_unitario;
  Ventas(
      this.total, this.nombre, this.fecha, this.cantidad, this.precio_unitario);

  Ventas.fromMap(Map<String, dynamic> map)
      : assert(map['nombre'] != null),
        assert(map['total'] != null),
        assert(map['fecha'] != null),
        assert(map['cantidad'] != null),
        assert(map['precio_unitario'] != null),
        total = map['total'],
        nombre = map['nombre'],
        fecha = map['fecha'],
        precio_unitario = map['precio_unitario'],
        cantidad = map['cantidad'];

  @override
  String toString() =>
      "Record<$nombre:$total:$fecha:$cantidad:$precio_unitario>";
}
