import 'dart:convert';

//recibe un json en forma de string => y devuelve una nueva instancia del modelo
CriptoModel criptoModelFromJson(String str) => CriptoModel.fromJson(json.decode(str));

//toma el modelo y lo genera a un json
String criptoModelToJson(CriptoModel data) => json.encode(data.toJson());

class CriptoModel {
    CriptoModel({
        this.id = '',
        this.valorActual = 0.0,
        this.valor24 = 0.0,
        this.mktCap = 0.0,
    });

    String id;
    double valorActual;
    double valor24;
    double mktCap;

    factory CriptoModel.fromJson(Map<String, dynamic> json) => CriptoModel(
        id: json["id"],
        valorActual: json["usd"].toDouble(),
        valor24: json["usd_24h_change"].toDouble(),
        mktCap: json["usd_market_cap"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "valorActual": valorActual,
        "valor24": valor24,
        "mktCap": mktCap,
    };
}
