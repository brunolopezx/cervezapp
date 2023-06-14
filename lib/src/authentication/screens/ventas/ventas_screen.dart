// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cervezapp2/src/authentication/mercadoPago/mp.dart';
import 'package:cervezapp2/src/authentication/repositories/auth_repository/auth.dart';
import 'package:cervezapp2/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mercado_pago_integration/core/failures.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:mercado_pago_integration/models/payment.dart';

import 'package:provider/provider.dart';
import '../../../providers/cart_item.dart';

// ignore: must_be_immutable
class VentasScreen extends StatelessWidget {
  late Map<String, Object> preference1;
  late Map<String, dynamic> datosBase;
  final idBar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idBar.text = args["idBar"];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMEd().format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Chip(
                      label: Text("${cart.totalAmount}"),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                preference1 = {
                  'items': [
                    {
                      'title': cart.items.values.toList()[index].nombre,
                      'description': 'Cerveza',
                      'quantity': cart.items.values.toList()[index].cantidad,
                      'currency_id': 'ARS',
                      'unit_price': cart.items.values.toList()[index].precio,
                    }
                  ],
                  'payer': {'email': Auth().currentUser!.email},
                };
                datosBase = {
                  'nombre': cart.items.values.toList()[index].nombre,
                  'total': cart.items.values.toList()[index].precio *
                      cart.items.values.toList()[index].cantidad,
                  'fecha': formattedDate.toString(),
                  'precio_unitario': cart.items.values.toList()[index].precio,
                  'cantidad': cart.items.values.toList()[index].cantidad,
                };

                return Dismissible(
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: FittedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "${cart.items.values.toList()[index].precio}"),
                        )),
                      ),
                      title:
                          Text("${cart.items.values.toList()[index].nombre}"),
                      subtitle: Text(
                          "Total: ${cart.items.values.toList()[index].precio * cart.items.values.toList()[index].cantidad}"),
                      trailing: Text(
                          "${cart.items.values.toList()[index].cantidad} x"),
                    ),
                  ),
                  key: ValueKey(cart.items.keys.toList()[index]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    cart.removeItem(cart.items.keys.toList()[index]);
                  },
                  background: Container(
                    padding: EdgeInsets.only(right: 20),
                    color: Theme.of(context).colorScheme.error,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                );
              },
              itemCount: cart.itemCount,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                "COMPRAR",
                style: TextStyle(color: colorSecundario),
              ),
              onPressed: () async {
                (await MercadoPagoIntegration.startCheckout(
                  publicKey: mp_key,
                  preference: preference1,
                  accessToken: mp_token,
                ))
                    .fold(
                        (Failure failure) =>
                            debugPrint('Failure => ${failure.message}'),
                        (Payment payment) =>
                            debugPrint('Payment => ${payment.paymentId}'));

                Navigator.pop(context);

                FirebaseFirestore.instance
                    .collection('bares')
                    .doc(idBar.text)
                    .collection('ventas')
                    .add({
                  'nombre': datosBase.values.elementAt(0).toString(),
                  'total': datosBase.values.elementAt(1),
                  'fecha': datosBase.values.elementAt(2).toString(),
                  'precio_unitario': datosBase.values.elementAt(3),
                  'cantidad': datosBase.values.elementAt(4)
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

//flutter run --no-sound-null-safety 