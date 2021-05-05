import 'package:challenge/src/models/cripo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:challenge/src/providers/cripo_provider.dart';
import 'package:challenge/src/providers/change_notifier.dart';
import 'package:challenge/src/providers/intercambiar.dart';

class SwapPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final lista = watch(listaMonedas);
    final cambiar = watch(cambioProvider);
    final intercambiar = new Intercambiar();
    final valorF = 2.20;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 20, 53, 1),
        centerTitle: true,
        title: Text('Intercambio - Ayala Lucas'),
      ),
      body: Stack(children: [
        _crearFondo(context),
        _loginForm(context, lista, cambiar, intercambiar, watch, valorF),
      ]),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(33, 86, 173, 1),
        Color.fromRGBO(77, 138, 240, 1),
      ])),
    );

    final circulo = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    final logo = Container(
      padding: EdgeInsets.only(top: 50.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Icon(Icons.transfer_within_a_station_rounded,
                color: Colors.white, size: 100.0),
            SizedBox(height: 10.0, width: double.infinity),
            Text('Intercambio',
                style: TextStyle(color: Colors.white, fontSize: 25.0))
          ],
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        logo,
      ],
    );
  }

  Widget _loginForm(
      BuildContext context,
      AsyncValue<List<CriptoModel>> lista,
      CambioList cambiar,
      Intercambiar inter,
      ScopedReader watch,
      double valorF) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 200.0)),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(80.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Table(
                      columnWidths: {0: FractionColumnWidth(0.3)},
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          lista.when(
                            data: (data) {
                              String _val;
                              List<DropdownMenuItem<String>> _list = [];

                              data.sort((a, b) => a.id.compareTo(b.id));

                              data.forEach((element) {
                                _list.add(DropdownMenuItem(
                                  child: Text(element.id),
                                  value: element.id,
                                ));
                              });

                              return DropdownButton(
                                hint: Text('Monedas'),
                                iconSize: 15,
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                value: _val = cambiar.valor1,
                                items: _list,
                                onChanged: (opt) {
                                  cambiar.cambio1(opt);
                                },
                              );
                            },
                            loading: () => CircularProgressIndicator(),
                            error: (e, s) => SizedBox(),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: '${cambiar.valor1}',
                              labelText: 'Cantidad',
                            ),
                          ),
                        ])
                      ]),
                ),
                SizedBox(height: 40.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: lista.when(
                    data: (data) {
                      String _value;
                      List<DropdownMenuItem<String>> _lista = [];

                      data.sort((a, b) => a.id.compareTo(b.id));

                      data.forEach((element) {
                        _lista.add(DropdownMenuItem(
                          child: Text(element.id),
                          value: element.id,
                        ));
                      });

                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: DropdownButton(
                          icon: Icon(Icons.table_rows_rounded),
                          iconSize: 18,
                          isExpanded: true,
                          style: GoogleFonts.nunito(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          hint: Text('Monedas'),
                          value: _value = cambiar.valor,
                          items: _lista,
                          onChanged: (opt) {
                            cambiar.cambio(opt);
                            inter.obtenerId(opt, watch);
                          },
                        ),
                      );
                    },
                    loading: () => CircularProgressIndicator(),
                    error: (e, s) => SizedBox(),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () => {
                            _mostrarAlert(
                                context, cambiar.valor, cambiar.valor1, valorF)
                          },
                      child: Text('Intercambiar',
                          style: GoogleFonts.nunito(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white))),
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Text('¿Necesita ayuda?'),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  void _mostrarAlert(context, String elegida, String elegida1, double valorF) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            title: Text('Usted posee de $elegida:'),
            content: Text(
              '$valorF US\$',
              style: TextStyle(fontSize: 40),
            ), //'1.000.000 US\$'
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Ok'))
            ],
          );
        });
  }
}
