import 'dart:convert';

import 'package:http/http.dart' as http;

class MonedaProvider {
  final apiURL = 'https://api.gael.cloud/general/public/monedas';

  Future<List<dynamic>> getMonedas() async {
    var url = Uri.parse(apiURL);
    var respuesta = await http.get(url);

    // await Future.delayed(Duration(seconds: 5));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<double> getValorMoneda(String codigoMoneda) async {
    var url = Uri.parse(apiURL + '/' + codigoMoneda);
    var respuesta = await http.get(url);
    var moneda = json.decode(respuesta.body);
    return double.parse(moneda['Valor'].replaceAll(',', '.'));
  }
}
