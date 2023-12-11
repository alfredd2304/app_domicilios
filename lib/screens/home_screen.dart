import 'package:app_domicilios/main.dart';
import 'package:app_domicilios/screens/Repartidor/repartidor_main.dart';
import 'package:app_domicilios/screens/Usuario/usuario_main.dart';
import 'package:app_domicilios/screens/login_screen.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                  },
                  child: const Text("Log Out")))
        ],
      ),
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
