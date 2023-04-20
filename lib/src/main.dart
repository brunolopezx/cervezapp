import 'dart:io';
import 'package:cervezapp2/src/authentication/screens/login/login_screen.dart';
import 'package:cervezapp2/src/authentication/screens/signup/sign_up_screen.dart';
import 'package:cervezapp2/src/authentication/screens/welcome-screen.dart';
import 'package:cervezapp2/src/constants/colors.dart';
import 'package:cervezapp2/src/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//TOKEN: 1//0fa-Ft94twVBlCgYIARAAGA8SNwF-L9IrMW3iFMsoZjb5j9N6K3LANXL_5IPpFRIFWHXUr661lvMyY792rk1on5KY07m_kUcQFLM

void main() {
  runApp(const CervezApp());
}

class CervezApp extends StatelessWidget {
  const CervezApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: CervezAppHome(),
      initialRoute: '/',
      routes: {
        '/home': (context) => CervezAppHome(),
        '/login': (context) => LoginScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}

class CervezAppHome extends StatefulWidget {
  const CervezAppHome({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  // ignore: library_private_types_in_public_api
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
        backgroundColor: colorPrincipal,
        title: (Text(
          "CervezApp",
          style: Theme.of(context).textTheme.titleLarge,
        )),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/welcome'),
              icon: Icon(Icons.person_outline_outlined))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text(
                "Menú",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Text("Bares"),
            Text("Promociones"),
            Text("3"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorPrincipal,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: colorSecundario,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.supervised_user_circle,
                color: colorSecundario,
              ),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assessment,
                color: colorSecundario,
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
