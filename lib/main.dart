// @dart=2.19
import 'dart:io';
import 'package:cervezapp2/src/authentication/screens/bares/bares_list_widget.dart';
import 'package:cervezapp2/src/authentication/screens/bares/edit_delete_bares.dart';
import 'package:cervezapp2/src/authentication/screens/bares/save_page.dart';
import 'package:cervezapp2/src/authentication/screens/cervezas/cervezas_list_widget.dart';
import 'package:cervezapp2/src/authentication/screens/cervezas/cervezas_save_page.dart';
import 'package:cervezapp2/src/authentication/screens/cervezas/edit_delete_cervezas.dart';
import 'package:cervezapp2/src/authentication/screens/forgotPassword/forget_password_mail_screen.dart';
import 'package:cervezapp2/src/authentication/screens/forgotPassword/otp_screen.dart';
import 'package:cervezapp2/src/authentication/screens/login/login_screen.dart';
import 'package:cervezapp2/src/authentication/screens/signup/sign_up_screen.dart';
import 'package:cervezapp2/src/authentication/screens/ventas/ventas_screen.dart';
import 'package:cervezapp2/src/authentication/screens/welcome-screen.dart';
import 'package:cervezapp2/src/constants/colors.dart';
import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:cervezapp2/src/providers/cart_item.dart';
import 'package:cervezapp2/src/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//TOKEN: 1//0fa-Ft94twVBlCgYIARAAGA8SNwF-L9IrMW3iFMsoZjb5j9N6K3LANXL_5IPpFRIFWHXUr661lvMyY792rk1on5KY07m_kUcQFLM

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CervezApp());
}

class CervezApp extends StatelessWidget {
  const CervezApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Cart())],
      child: MaterialApp(
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
          '/forgetPassword': (context) => ForgetPasswordMailScreen(),
          '/otp': (context) => OTPScreen(),
          '/bares': (context) => BaresListWidget(),
          '/saveBares': (context) => SaveBaresPage(),
          '/editDeleteBares': (context) => EditDeleteBares(),
          '/cervezas': (context) => CervezasListWidget(),
          '/saveCervezas': (context) => SaveCervezasPage(),
          '/editDeleteCervezas': (context) => EditDeleteCervezas(),
          '/ventas': (context) => VentasScreen(),
        },
      ),
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
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       DrawerHeader(
      //         child: Text(
      //           "Menú",
      //           style: Theme.of(context).textTheme.displaySmall,
      //         ),
      //       ),
      //       TextButton(
      //           onPressed: () {
      //             Navigator.pushNamed(context, '/bares');
      //           },
      //           child: Text("Bares")),
      //       TextButton(
      //           onPressed: () {
      //             Navigator.pushNamed(context, '/promociones');
      //           },
      //           child: Text("Promociones")),
      //     ],
      //   ),
      // ),
      drawer: Drawer(
        child: Container(
          color: colorPrincipal,
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: Image(image: AssetImage(welcomeImage)),
              ),
              const Text(
                "Menú",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/bares');
                    },
                    child: Text("Bares")),
              ),
            ],
          ),
        ),
      ),
      body: Container(),
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
