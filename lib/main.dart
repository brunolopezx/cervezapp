// @dart=2.19
import 'dart:async';
import 'package:cervezapp2/src/authentication/maps/locations.dart';
import 'package:cervezapp2/src/authentication/screens/auth_page.dart';
import 'package:cervezapp2/src/authentication/screens/bares/bares_list_widget.dart';
import 'package:cervezapp2/src/authentication/screens/bares/edit_delete_bares.dart';
import 'package:cervezapp2/src/authentication/screens/bares/save_page.dart';
import 'package:cervezapp2/src/authentication/screens/cervezas/cervezas_list_widget.dart';
import 'package:cervezapp2/src/authentication/screens/cervezas/cervezas_save_page.dart';
import 'package:cervezapp2/src/authentication/screens/cervezas/edit_delete_cervezas.dart';
import 'package:cervezapp2/src/authentication/screens/forgotPassword/forget_password_mail_screen.dart';
import 'package:cervezapp2/src/authentication/screens/forgotPassword/otp_screen.dart';
import 'package:cervezapp2/src/authentication/screens/login/login_screen.dart';
import 'package:cervezapp2/src/authentication/screens/profile.dart';
import 'package:cervezapp2/src/authentication/screens/signup/sign_up_screen.dart';
import 'package:cervezapp2/src/authentication/screens/ventas/ventas_screen.dart';
import 'package:cervezapp2/src/authentication/screens/welcome-screen.dart';
import 'package:cervezapp2/src/constants/colors.dart';
import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:cervezapp2/src/providers/cart_item.dart';
import 'package:cervezapp2/src/themes/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

//TOKEN: 1//0fa-Ft94twVBlCgYIARAAGA8SNwF-L9IrMW3iFMsoZjb5j9N6K3LANXL_5IPpFRIFWHXUr661lvMyY792rk1on5KY07m_kUcQFLM
//flutter run --no-sound-null-safety

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.camera.status;
  if (await Permission.contacts.request().isGranted) {
    // Either the permission was already granted before or the user just granted it.
  }
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
  ].request();
  print(statuses[Permission.location]);
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
          '/auth': (context) => AuthPage(),
          '/profile': (context) => ProfileScreen(),
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
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static final CameraPosition _default = CameraPosition(
    target: patioOlmos(),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return material();
  }

  Widget material() {
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/bares');
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
                      Navigator.pushNamed(context, '/bares');
                    },
                    child: Text("Promociones")),
              ),
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
              //   child: Text(
              //     'Cuenta: ' + getName().toString(),
              //     style: TextStyle(
              //         color: Colors.white, fontStyle: FontStyle.italic),
              //   ),
              // ),
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
