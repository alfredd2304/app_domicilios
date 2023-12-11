import 'package:app_domicilios/screens/Repartidor/repartidor_main.dart';
import 'package:app_domicilios/screens/Usuario/usuario_main.dart';
import 'package:app_domicilios/providers/estado_pedido.dart';
import 'package:app_domicilios/providers/pedido_realizado.dart';
import 'package:app_domicilios/screens/home_screen.dart';
import 'package:app_domicilios/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PedidoRealizadoProvider()),
      ChangeNotifierProvider(create: (_) => EstadoPedidoProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const LoginScreen(),
      ),
    );
  }
}
