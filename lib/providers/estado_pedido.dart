import 'package:flutter/material.dart';

class EstadoPedidoProvider with ChangeNotifier {
  String _estadoPedido = "Nuevo";

  String get estadoPedido => _estadoPedido;

  void onEstadoPedidoChange() {
    switch (_estadoPedido) {
      case "En preparacion":
        _estadoPedido = "Despachado";
        break;
      case "Despachado":
        _estadoPedido = "Entregado";
        break;
      case "Entregado":
        _estadoPedido = "Queja";
        break;
      case "Queja":
        _estadoPedido = "Finalizado";
        break;

      default:
        _estadoPedido = "En preparacion";
    }

    notifyListeners();
  }
}
