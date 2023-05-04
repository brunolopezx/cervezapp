import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/cart_item.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getItems() async {
  List carrito = [];
  QuerySnapshot querySnapshot = await db.collection('cart_item').get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map items = {
      "nombre": data["nombre"],
      "id": doc.id,
      "precio": data["precio"],
      "fecha": data["fecha"],
      "cantidad": data["cantidad"]
    };

    carrito.add(items);
  }
  return carrito;
}

Future<void> addPeople(String name) async {
  await db.collection("people").add({"name": name});
}

Future<void> addItem(
    String id, double precio, String nombre, String fecha) async {
  await db
      .collection("cart_item")
      .add({"precio": precio, "cantidad": 1, "nombre": nombre, "fecha": fecha});
  print("$nombre fue agregado al carrito");
}

Future<void> deleteItem(String id) async {
  await db.collection("cart_item").doc(id).delete();
}
