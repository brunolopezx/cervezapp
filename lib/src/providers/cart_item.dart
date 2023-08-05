import 'package:flutter/material.dart';

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

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get cantidadTotal {
    var canti = 0;
    _items.forEach((key, value) {
      canti += value.cantidad;
    });
    return canti;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total = total + cartItem.precio * cartItem.cantidad;
    });
    return total;
  }

  void addItem(String id, double precio, String nombre, String fecha) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (existing) => CartItem(
              id: existing.id,
              precio: existing.precio,
              cantidad: existing.cantidad + 1,
              nombre: existing.nombre,
              fecha: existing.fecha));
      print("$nombre se sumó a la lista");
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              precio: precio,
              cantidad: 1,
              nombre: nombre,
              fecha: fecha));
      print("$nombre fue agregado al carrito");
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeAllItems() {
    _items.clear();
  }
}
