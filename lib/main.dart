import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:challenge/src/pages/rutas/rutas.dart';
 
 
void main() => runApp(ProviderScope(child: MyApp()));
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: getAplicationRoutes(),
    );
  }
}