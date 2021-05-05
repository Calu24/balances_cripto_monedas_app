import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:challenge/src/providers/cripo_provider.dart';
import 'package:challenge/src/models/cripo_model.dart';

class Intercambiar extends ChangeNotifier {
  AsyncValue<List<CriptoModel>> _lista;
  double _valorMoneda;


  void obtenerId(String id, ScopedReader watch){
    _lista = watch(listaMonedas);

    _lista.when(
      data: (data) {
        var _obtenido = data.where((element) => element.id == id);

        _obtenido.forEach((element) {
          _valorMoneda = element.valorActual;
          notifyListeners();
        });
      },
      loading: () => print('Cargando'),
      error: (e, s) => print('$e + $s'),
    );

  }

  //var valorFinal = ChangeNotifierProvider((ref) => Intercambiar().valor);

  double get valor {
    notifyListeners();
    return _valorMoneda;
  }
}
