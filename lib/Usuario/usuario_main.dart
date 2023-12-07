import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserOrderState()));
          });
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 25, vertical: 15))),
        child: const Text("Realizar Pedido"),
      ),
    );
  }
}

class UserOrderState extends StatefulWidget {
  const UserOrderState({super.key});

  @override
  State<UserOrderState> createState() => _UserOrderStateState();
}

class _UserOrderStateState extends State<UserOrderState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedido del Usuario"),
      ),
      body: const Column(children: [Text("Estado Del pedido: ****")]),
    );
  }
}
