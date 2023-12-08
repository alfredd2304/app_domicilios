import 'package:flutter/material.dart';

class PedidoRealizadoProvider with ChangeNotifier {
  bool _pedidoRealizado = false;

  bool get pedidoRealizado => _pedidoRealizado;

  void onPedidoRealizado() {
    _pedidoRealizado = true;
    notifyListeners();
  }
}
