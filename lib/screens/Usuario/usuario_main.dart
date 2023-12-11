import 'package:app_domicilios/providers/estado_pedido.dart';
import 'package:app_domicilios/providers/pedido_realizado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          bool pedidoRealizado =
              context.read<PedidoRealizadoProvider>().pedidoRealizado;
          if (pedidoRealizado == false) {
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

              context.read<PedidoRealizadoProvider>().onPedidoRealizado();

              _mostrarAlerta(context);
            });
          } else if (pedidoRealizado == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserOrderState()));
          }
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 25, vertical: 15))),
        child: Text(context.watch<PedidoRealizadoProvider>().pedidoRealizado
            ? "Ver Pedido"
            : "Realizar Pedido"),
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
    String estadoPedido = context.read<EstadoPedidoProvider>().estadoPedido;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pedido del Usuario"),
        ),
        body: Column(children: [Text("Estado Del pedido: $estadoPedido")]));
  }
}

void _mostrarAlerta(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Pedido Creado"),
        content: const Text("El pedido fue creado con éxito."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}