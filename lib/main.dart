import 'package:app_domicilios/Repartidor/repartidor_main.dart';
import 'package:app_domicilios/Usuario/usuario_main.dart';
import 'package:app_domicilios/providers/estado_pedido.dart';
import 'package:app_domicilios/providers/pedido_realizado.dart';
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
        body: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [UserHome(), RepartidorHome()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuario"),
          BottomNavigationBarItem(
              icon: Icon(Icons.pedal_bike_sharp), label: "Repartidor")
        ],
      ),
    );
  }
}
