import 'package:cliente_autos/provider/autos_provider.dart';
import 'package:flutter/material.dart';

class MarcasAgregar extends StatefulWidget {
  MarcasAgregar({Key? key}) : super(key: key);

  @override
  _MarcasAgregarState createState() => _MarcasAgregarState();
}

class _MarcasAgregarState extends State<MarcasAgregar> {
  TextEditingController nombreCtrl = TextEditingController();
  String textoError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Marca'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: InputDecoration(
                labelText: 'Marca de Autos',
                hintText: 'Nombre del fabricante de autos',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                textoError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  textStyle: TextStyle(color: Colors.white),
                ),
                child: Text('Agregar'),
                onPressed: () async {
                  // print(nombreCtrl.text);
                  AutosProvider provider = AutosProvider();
                  var respuesta = await provider.marcasAgregar(nombreCtrl.text);

                  if (respuesta['message'] != null) {
                    setState(() {
                      textoError = respuesta['errors']['nombre'][0];
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
