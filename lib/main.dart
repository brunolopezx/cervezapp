import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//TOKEN: 1//0fa-Ft94twVBlCgYIARAAGA8SNwF-L9IrMW3iFMsoZjb5j9N6K3LANXL_5IPpFRIFWHXUr661lvMyY792rk1on5KY07m_kUcQFLM

void main() {
  runApp(CervezApp());
}

class CervezApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CervezApp",
      home: CervezAppHome(title: "CervezApp Home"),
    );
  }
}

class CervezAppHome extends StatefulWidget {
  CervezAppHome({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CervezAppHomeState createState() => _CervezAppHomeState();
}

class _CervezAppHomeState extends State<CervezAppHome> {
  int _elementoSeleccionado = 0;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? material() : cupertino();
  }

  Widget material() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: (Text(widget.title!)),
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.home))],
      ),
      drawer: Drawer(
        child: Column(
          children: const [
            DrawerHeader(
              child: Text(
                "Menú",
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(" 1"),
            Text("2"),
            Text("3"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assessment,
                color: Colors.white,
              ),
              label: "Ayuda"),
        ],
        currentIndex: _elementoSeleccionado,
        onTap: _itemPulsado,
      ),
    );
  }

  Widget cupertino() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assessment,
                color: Colors.white,
              ),
              label: "Ayuda"),
        ],
        currentIndex: _elementoSeleccionado,
        onTap: _itemPulsado,
      ),
      backgroundColor: Colors.greenAccent,
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: Column(
                      children: [
                        Text("$index: Inicio"),
                      ],
                    ),
                  ),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: Column(
                      children: [
                        Text("$index: Perfil"),
                      ],
                    ),
                  ),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: Column(
                      children: [
                        Text("$index: Ayuda"),
                      ],
                    ),
                  ),
                );
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: Center(
                    child: Column(
                      children: [
                        Text("$index: Inicio"),
                      ],
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }

//Funciones
  void _itemPulsado(int index) {
    setState(() {
      _elementoSeleccionado = index;
    });
  }
}
