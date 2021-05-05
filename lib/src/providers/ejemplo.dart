import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncrementNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;


  void increment() {
    _value ++;
    notifyListeners();
  }
}

final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());

final saludoProvider = Provider((ref) => 'Hola a todos desde el riverpod');