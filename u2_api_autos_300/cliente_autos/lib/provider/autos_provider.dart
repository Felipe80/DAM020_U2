import 'dart:collection';
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

  Future<LinkedHashMap<String, dynamic>> marcasAgregar(
      String nombreMarca) async {
    var uri = Uri.parse('$apiURL/marcas');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{'nombre': nombreMarca}),
    );

    return json.decode(respuesta.body);
  }

  Future<bool> marcaBorrar(int id) async {
    var uri = Uri.parse('$apiURL/marcas/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> marcasEditar(
      int id, String nombreMarca) async {
    var uri = Uri.parse('$apiURL/marcas/$id');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{'nombre': nombreMarca}),
    );

    return json.decode(respuesta.body);
  }

  Future<List<dynamic>> getAutos() async {
    var uri = Uri.parse('$apiURL/autos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> getAuto(String patente) async {
    var uri = Uri.parse('$apiURL/autos/$patente');
    var respuesta = await http.get(uri);
    return json.decode(respuesta.body);
  }

  Future<bool> autosBorrar(String patente) async {
    var uri = Uri.parse('$apiURL/autos/$patente');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> autosAgregar(
      String patente, String modelo, int precio, int marcaId) async {
    var uri = Uri.parse('$apiURL/autos');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'patente': patente,
        'modelo': modelo,
        'precio': precio,
        'marca': marcaId,
      }),
    );

    return json.decode(respuesta.body);
  }
}
