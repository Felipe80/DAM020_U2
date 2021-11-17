import 'package:cliente_api/provider/autos_provider.dart';
import 'package:flutter/material.dart';

class AutosAgregar extends StatefulWidget {
  AutosAgregar({Key? key}) : super(key: key);

  @override
  _AutosAgregarState createState() => _AutosAgregarState();
}

class _AutosAgregarState extends State<AutosAgregar> {
  TextEditingController patenteCtrl = TextEditingController();
  TextEditingController modeloCtrl = TextEditingController();
  TextEditingController precioCtrl = TextEditingController();
  AutosProvider provider = AutosProvider();
  int marcaId = 0;
  String errPatente = '', errModelo = '', errPrecio = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Auto'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: patenteCtrl,
              decoration: InputDecoration(labelText: 'Patente'),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                errPatente,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: modeloCtrl,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                errModelo,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextField(
              controller: precioCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Precio'),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                errPrecio,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Container(
              width: double.infinity,
              child: FutureBuilder(
                future: provider.getMarcas(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return DropdownButton<int>(
                    value: marcaId == 0 ? null : marcaId,
                    hint: Text('Marca'),
                    isExpanded: true,
                    items: snapshot.data.map<DropdownMenuItem<int>>((marca) {
                      return DropdownMenuItem<int>(
                        child: Text(marca['nombre']),
                        value: marca['id'],
                      );
                    }).toList(),
                    onChanged: (marcaSeleccionada) {
                      setState(() {
                        marcaId = marcaSeleccionada!;
                      });
                    },
                  );
                },
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Agregar Auto'),
                onPressed: () async {
                  int precio = precioCtrl.text.trim().isEmpty
                      ? 0
                      : int.parse(precioCtrl.text.trim());
                  var respuesta = await provider.autosAgregar(
                    patenteCtrl.text.trim(),
                    modeloCtrl.text.trim(),
                    precio,
                    marcaId,
                  );
                  if (respuesta['message'] != null) {
                    setState(() {
                      var errores = respuesta['errors'];
                      errPatente = errores['patente'] != null
                          ? errores['patente'][0]
                          : '';
                      errModelo =
                          errores['modelo'] != null ? errores['modelo'][0] : '';
                      errPrecio =
                          errores['precio'] != null ? errores['precio'][0] : '';
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
