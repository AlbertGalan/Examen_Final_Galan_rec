import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/services/services.dart';
import '/screens/home_screen.dart';
import '/screens/login_screen.dart';
import '/screens/details_screen.dart';
import '/services/services_ip.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Service()), // Provee el UserService
        ChangeNotifierProvider(create: (_) => ServicesIP()), // Provee el ServicesIP
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD amb Beeceptor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Ruta inicial
      routes: {
        '/login': (context) => LoginScreen(), // Pantalla de inicio de sesión
        '/home': (context) => HomeScreen(), // Pantalla principal
        '/userDetail': (context) => DetailScreen(
              user: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ), // Pantalla de detalles del usuario
      },
    );
  }
}