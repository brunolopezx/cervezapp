import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/images_strings.dart';
import '../../maps/locations.dart';
import '../../repositories/auth_repository/auth.dart';

class ClienteHome extends StatefulWidget {
  const ClienteHome({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ClienteHomeState createState() => _ClienteHomeState();
}

class _ClienteHomeState extends State<ClienteHome> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static final CameraPosition _default = CameraPosition(
    target: patioOlmos(),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
        title: (Text(
          "CervezApp",
          style: TextStyle(
            color: colorSecundario,
            fontWeight: FontWeight.w400,
          ),
        )),
        actions: [
          IconButton(
            onPressed: () => {
              if (FirebaseAuth.instance.currentUser == null)
                {Navigator.pushNamed(context, '/welcome')}
              else
                {Navigator.pushNamed(context, '/profile')}
            },
            icon: Icon(Icons.person_outline_outlined),
            color: colorSecundario,
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: colorSecundario,
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: Image(
                  image: AssetImage(welcomeImage),
                  alignment: Alignment.bottomLeft,
                ),
              ),
              const Text(
                "Menú",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.white),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                width: double.infinity,
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.amberAccent),
                      elevation: MaterialStateProperty.all(2),
                    ),
                    onPressed: () async {
                      if (Auth().currentUser == null) {
                        CircularProgressIndicator();
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                      'Debe loguearse para realizar una compra'),
                                  icon: Icon(Icons.assignment_ind_rounded),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(color: colorAccent),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                )).then(
                            (_) => Navigator.pushNamed(context, '/welcome'));
                      } else {
                        Navigator.pushNamed(context, '/baresListCliente');
                      }
                    },
                    child: Text("Bares")),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                width: double.infinity,
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.amberAccent),
                      elevation: MaterialStateProperty.all(2),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/baresPromoCliente');
                    },
                    child: Text("Promociones")),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/faq');
                      },
                      child: Text.rich(
                        TextSpan(text: 'FAQ'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/terminos');
                      },
                      child: Text.rich(
                        TextSpan(text: 'Términos y Condiciones'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
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
            height: 5,
          ),
          SizedBox(
            height: 280,
            width: double.infinity,
            child: Container(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _default,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: createMarker(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
