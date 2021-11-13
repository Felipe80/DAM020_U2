import 'package:cliente_autos/provider/autos_provider.dart';
import 'package:flutter/material.dart';

class MarcasEditar extends StatefulWidget {
  int id;
  String nombre;

  MarcasEditar({Key? key, this.id = 0, this.nombre = ''}) : super(key: key);

  @override
  _MarcasEditarState createState() => _MarcasEditarState();
}

class _MarcasEditarState extends State<MarcasEditar> {
  TextEditingController nombreCtrl = TextEditingController();
  String textoError = '';

  @override
  void initState() {
    super.initState();
    nombreCtrl.text = widget.nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Marca'),
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
                child: Text('Editar'),
                onPressed: () async {
                  AutosProvider provider = AutosProvider();
                  var respuesta =
                      await provider.marcasEditar(widget.id, nombreCtrl.text);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
