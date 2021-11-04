import 'dart:convert';

import 'package:http/http.dart' as http;

class AutosProvider {
  final String apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getMarcas() async {
    var uri = Uri.parse('$apiURL/marcas');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }
}
