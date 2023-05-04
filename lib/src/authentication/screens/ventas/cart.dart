import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/cart_item.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
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
}
