import 'package:flutter/material.dart';


import 'package:challenge/src/pages/home_page.dart';
import 'package:challenge/src/pages/swap_page.dart';


Map<String, WidgetBuilder> getAplicationRoutes(){

  return <String, WidgetBuilder> {
        'home'                  : (BuildContext context) => HomePage(),
        'swap'                  : (BuildContext context) => SwapPage(),

      };

}

