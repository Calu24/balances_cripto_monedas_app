import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:challenge/src/models/cripo_model.dart';
import 'package:challenge/src/pages/swap_page.dart';
import 'package:challenge/src/providers/cripo_provider.dart';


class HomePage extends ConsumerWidget {
  final criptoProvider = new CriptoProvider();

  @override
  Widget build(BuildContext context, watch) {
    //final saludo = watch(saludoProvider);
    //final incremento = watch(moneda);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 20, 53, 1),
        elevation: 10.0,
        centerTitle: true,
        title: Text(
          'Balances - Ayala Lucas',
          style:
              GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: [
        _fondo(),
        _tablaProvider(),
        _header(),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(1, 20, 53, 1),
        onPressed: () {
          Navigator.push(context, _transicionAnimada());
        },
        child: Icon(Icons.attach_money),
      ),
    );
  }

  Widget _tablaProvider() {
    return FutureBuilder(
        future: criptoProvider.cargarCriptos(),
        builder: (context, AsyncSnapshot<List<CriptoModel>> snapshot) {
          if (snapshot.hasData) {
            final cripoMonedas = snapshot.data;
            //ordenar:
            cripoMonedas.sort((a, b) => b.valorActual.compareTo(a.valorActual));
            
            return Positioned(
                top: 70.0,
                child: Container(
                    height: MediaQuery.of(context).size.height - 160,
                    width: MediaQuery.of(context).size.width,
                    child: Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: cripoMonedas.length,
                            itemBuilder: (context, i) =>
                                _itemsMonedas(cripoMonedas[i])))));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Route _transicionAnimada() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          SwapPage(),
      transitionDuration: Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation =
            CurvedAnimation(parent: animation, curve: Curves.ease);

        return SlideTransition(
          child: child,
          position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
              .animate(curvedAnimation),
        );
      },
    );
  }

  Widget _itemsMonedas(CriptoModel cripoMoneda) {
    final double valor =
        double.parse((cripoMoneda.valorActual).toStringAsFixed(4));
    final double porcentaje =
        double.parse((cripoMoneda.valor24).toStringAsFixed(2));

    TextStyle estiloCards = GoogleFonts.nunito(
        fontSize: 20.0, fontWeight: FontWeight.w100, color: Colors.white);

    return Card(
      color: Color.fromRGBO(214, 219, 223, 0.05),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17.0, 8.0, 10.0, 8.0),
        child: Table(
          columnWidths: {0: FractionColumnWidth(0.5)},
          children: [
            TableRow(children: [
              Text(
                '${cripoMoneda.id}',
                style: estiloCards,
              ),
              Text('\$$valor', style: estiloCards),
              Text(
                '$porcentaje%',
                style: GoogleFonts.nunito(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: porcentaje < 0 ? Colors.red : Colors.green,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  Widget _fondo() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
            Color.fromRGBO(33, 86, 173, 1),
            Color.fromRGBO(77, 138, 240, 1),
          ])),
    );
  }

  Widget _header() {
    TextStyle estiloCards = GoogleFonts.nunito(
        fontSize: 20.0, fontWeight: FontWeight.w100, color: Colors.white);
    return Table(
      columnWidths: {
        0: FractionColumnWidth(0.35)
      },
      children: [
        TableRow(children: [
          Card(
            margin: EdgeInsets.only(top: 10, left: 5),
            elevation: 15.0,
            color: Color.fromRGBO(1, 20, 53, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: TextButton(
              onPressed: () {

              },
              child: Text('Moneda',
                  style: estiloCards, textAlign: TextAlign.center),
            ),
          ),
          Card(
            margin: EdgeInsets.only(top: 10, left: 70),
            elevation: 15.0,
            color: Color.fromRGBO(1, 20, 53, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: TextButton(
              onPressed: () {},
              child:
                  Text('USD', style: estiloCards, textAlign: TextAlign.center),
            ),
          ),
          Card(
            margin: EdgeInsets.only(top: 10, left: 45, right: 5),
            elevation: 15.0,
            color: Color.fromRGBO(1, 20, 53, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: TextButton(
              onPressed: () {},
              child:
                  Text('24hs', style: estiloCards, textAlign: TextAlign.center),
            ),
          ),
        ])
      ],
    );
  }
}
