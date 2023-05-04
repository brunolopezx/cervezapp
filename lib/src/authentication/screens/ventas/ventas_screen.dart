import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VentasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = CartProvider();
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("cart_item").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<DocumentSnapshot> items = snapshot.data!.docs;

            return Column(
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
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          // Chip(
                          //   label: Text("${cart.totalAmount}"),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      Map<String, dynamic> data =
                          items[index].data() as Map<String, dynamic>;
                      return Dismissible(
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: FittedBox(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${data[index].precio}"),
                              )),
                            ),
                            title: Text("${data[index].nombre}"),
                            subtitle: Text(
                                "Total: ${data[index].precio * data[index].cantidad}"),
                            trailing: Text("${data[index].cantidad} x"),
                          ),
                        ),
                        key: ValueKey(snapshot.data?.docs[index].id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          //cart.deleteItem(snapshot.data?.docs[index]['uid']);
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
                    itemCount: snapshot.data?.size,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      "Comprar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CartProvider {}
