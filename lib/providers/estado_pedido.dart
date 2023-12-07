import 'package:flutter/material.dart';

class EstadoPedidoProvider with ChangeNotifier {
  bool _pedidoRealizado = false;

  bool get estadoPedido => _pedidoRealizado;

  void onPedidoRealizado() {
    _pedidoRealizado = true;
    notifyListeners();
  }
}
