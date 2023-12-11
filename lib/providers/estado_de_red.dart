import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class EstadoDeRedProvider with ChangeNotifier {
  bool _estadoRed = false;

  bool get estadoRed => _estadoRed;

  Future<void> onVerificarEstadoDeRed() async {
    var resultado = await (Connectivity().checkConnectivity());
    if (resultado == ConnectivityResult.mobile ||
        resultado == ConnectivityResult.wifi) {
      _estadoRed = true;
      notifyListeners();
    } else {
      _estadoRed = false;
    }
    notifyListeners();
  }
}
