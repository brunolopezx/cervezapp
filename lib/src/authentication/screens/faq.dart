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
                  Text(
                    'Tienes alguna duda o quieres comunicarte con nosotros?',
                    style: TextStyle(
                      fontSize: 20,
                      color: colorAccent,
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Cómo realizo una compra?'),
                children: [
                  Text(
                      'Primero debe crearse una cuenta, luego, en el home haga click en el botón de arriba a la izquierda para abrir el menú. Una vez ahí, seleccione la opción *Bares* para mostrar los bares disponibles. Elija el bar en el que se encuentra y la bebida que desee, pulse el botón *Comprar*, seleccione el método de pago y listo!')
                ],
              ),
              ExpansionTile(
                title: Text('Qué métodos de pago aceptan?'),
                children: [
                  Text("Los métodos de pago aceptados son: \n" +
                      " *Tarjeta de crédito \n" +
                      " *Tarjeta de débito \n" +
                      " *Efectivo en caja"),
                ],
              ),
              ExpansionTile(
                title: Text('Cómo creo un usuario?'),
                children: [
                  Text(
                      'En el menú principal, haga click a su derecha en el ícono de usuarios. Ahí seleccione *SIGN UP* y complete con sus datos para crear su cuenta')
                ],
              ),
              ExpansionTile(
                title: Text('Contanctame al email'),
                children: [
                  Text(
                    'Enviar email a: brunolopez164@gmail.com',
                    style: TextStyle(color: colorSecundario),
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
