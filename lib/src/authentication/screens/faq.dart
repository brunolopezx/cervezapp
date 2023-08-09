//@dart = 2.19
import 'package:cervezapp2/src/constants/colors.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Container(
                      child: Image(
                        image: AssetImage("assets/images/Cerve.png"),
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.colorBurn,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    collapsedIconColor: Colors.black,
                    iconColor: Colors.black,
                    collapsedBackgroundColor: Colors.black,
                    title: Text(
                      'Tienes alguna duda o quieres comunicarte con nosotros?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ExpansionTile(
                collapsedBackgroundColor: colorPrincipal,
                textColor: Colors.blue.shade400,
                collapsedShape: OutlineInputBorder(),
                shape: OutlineInputBorder(),
                title: Text(
                  'Cómo realizo una compra?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                children: [
                  Text(
                      '\n Primero debe crearse una cuenta, luego, \n ' +
                          ' en el home haga click en el botón de arriba a la \n' +
                          ' izquierda para abrir el menú. \n' +
                          ' Una vez ahí, seleccione la opción BARES para mostrar los bares disponibles. Elija el bar en el que se encuentra \n' +
                          ' y la bebida que desee, pulse el botón COMPRAR, seleccione el método de pago y listo!',
                      style: TextStyle(color: Colors.white))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ExpansionTile(
                collapsedBackgroundColor: colorPrincipal,
                textColor: Colors.blue.shade400,
                collapsedShape: OutlineInputBorder(),
                shape: OutlineInputBorder(),
                title: Text(
                  'Qué métodos de pago aceptan?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                children: [
                  Text(
                    "Los métodos de pago aceptados son: \n" +
                        " -Tarjeta de crédito \n" +
                        " -Efectivo en caja, previamente realizando la compra en la app",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ExpansionTile(
                collapsedBackgroundColor: colorPrincipal,
                textColor: Colors.blue.shade400,
                collapsedShape: OutlineInputBorder(),
                shape: OutlineInputBorder(),
                title: Text(
                  'Cómo creo un usuario?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                children: [
                  Text(
                      'En el menú principal, haga click a su derecha en el ícono de usuarios. \n' +
                          'Ahí seleccione SIGN UP y complete con sus datos para crear su cuenta',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ExpansionTile(
                collapsedBackgroundColor: colorPrincipal,
                textColor: Colors.blue.shade400,
                collapsedShape: OutlineInputBorder(),
                shape: OutlineInputBorder(),
                title: Text(
                  'Contáctanos',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                children: [
                  Text(
                    'Enviar email a: brunolopez164@gmail.com',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
