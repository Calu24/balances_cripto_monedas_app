import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CambioList extends ChangeNotifier {
  String _valor;
  String _valor1;

  void cambio(String moneda) {
    
    _valor = moneda;

    notifyListeners();
  }

  String get valor{
    return _valor;
  }
  //dropdown 1:
  void cambio1(String moneda) {
    
    _valor1 = moneda;

    notifyListeners();
  }

  String get valor1{
    return _valor1;
  }

}


final cambioProvider = ChangeNotifierProvider((ref) => CambioList());