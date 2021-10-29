import 'dart:convert';

import 'package:http/http.dart' as http;

class DpaProvider {
  final String apiURL = 'https://apis.digital.gob.cl/dpa';

  Future<List<dynamic>> getRegiones() async {
    var uri = Uri.parse('$apiURL/regiones');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getProvincias(String region) async {
    if (region.isEmpty) {
      return [];
    }

    var uri = Uri.parse('$apiURL/regiones/$region/provincias');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getComunas(String region, String provincia) async {
    if (region.isEmpty || provincia.isEmpty) {
      return [];
    }

    var uri =
        Uri.parse('$apiURL/regiones/$region/provincias/$provincia/comunas');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }
}
