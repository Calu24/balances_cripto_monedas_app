import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:challenge/src/models/cripo_model.dart';


class CriptoProvider{
  
  final String _url = 'https://api.coingecko.com/api/v3';


  Future<List<CriptoModel>> cargarCriptos() async{

    final url  = '$_url/simple/price?ids=bitcoin,ethereum,dogecoin,tether,cardano,binancecoin,polkadot,uniswap,litecoin,chainlink,solana,stellar,filecoin,tron,monero,aave,neo,iota,eos&vs_currencies=usd&include_market_cap=true&include_24hr_change=true';
    final resp = await http.get(Uri.parse(url));

    
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<CriptoModel> monedas = [];

    
    if(decodedData == null) return [];

    if(decodedData['error'] != null) return [];


    decodedData.forEach((id, moneda) { 
    
      final monedaTemp = CriptoModel.fromJson(moneda);
      monedaTemp.id = id;

      monedas.add(monedaTemp);
      
     });

     
    return monedas;

  }
}

final criptoProvider = new CriptoProvider();
final listaMonedas = FutureProvider<List<CriptoModel>>((ref) => criptoProvider.cargarCriptos());