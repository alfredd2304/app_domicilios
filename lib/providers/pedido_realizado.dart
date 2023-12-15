import 'package:flutter/material.dart';

class PedidoRealizadoProvider with ChangeNotifier {
  bool _pedidoRealizado = false;

  bool get pedidoRealizado => _pedidoRealizado;

  Future<void> onPedidoRealizado() async {
    _pedidoRealizado = true;
    notifyListeners();
  }
}
