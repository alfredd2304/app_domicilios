import 'package:app_domicilios/providers/estado_pedido.dart';
import 'package:app_domicilios/providers/pedido_realizado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepartidorHome extends StatefulWidget {
  const RepartidorHome({super.key});

  @override
  State<RepartidorHome> createState() => _RepartidorHomeState();
}

class _RepartidorHomeState extends State<RepartidorHome> {
  @override
  Widget build(BuildContext context) {
    bool pedidoRealizado =
        context.read<PedidoRealizadoProvider>().pedidoRealizado;
    if (pedidoRealizado == false) {
      return const Center(
        child: Text("Sin pedidos activos", style: TextStyle(fontSize: 30)),
      );
    } else if (pedidoRealizado == true) {
      String estadoPedido = context.watch<EstadoPedidoProvider>().estadoPedido;
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Tienes un nuevo pedido"),
          Text("El estado del pedido es: $estadoPedido"),
          if (estadoPedido != "Finalizado")
            ElevatedButton(
              onPressed: () {
                _mostrarAlerta(context);
              },
              child: const Text("Cambiar estado"),
            )
          else
            const SizedBox()
        ],
      ));
    }
    return Container();
  }
}

void _mostrarAlerta(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cambiar estado del pedido"),
          content: const Text("Seguro que desea cambiar el estado del pedido?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar",
                    style: TextStyle(
                      color: Colors.red,
                    ))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  context.read<EstadoPedidoProvider>().onEstadoPedidoChange();
                },
                child: const Text("Confirmar")),
          ],
        );
      });
}
