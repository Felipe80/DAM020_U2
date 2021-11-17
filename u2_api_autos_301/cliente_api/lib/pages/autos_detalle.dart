import 'package:cliente_api/provider/autos_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AutosDetalle extends StatefulWidget {
  String patente;
  AutosDetalle({Key? key, this.patente = ''}) : super(key: key);

  @override
  _AutosDetalleState createState() => _AutosDetalleState();
}

class _AutosDetalleState extends State<AutosDetalle> {
  AutosProvider provider = AutosProvider();
  var fPrecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Auto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: provider.getAuto(widget.patente),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var auto = snapshot.data;
            return Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(MdiIcons.carInfo),
                        title: Text(
                          'Detalle del auto patente ${auto['patente']}',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Patente: ${auto['patente']}'),
                              Text(
                                  'Marca: ${auto['marca'] == null ? 'Sin marca' : auto['marca']['nombre']}'),
                              Text('Modelo: ${auto['modelo']}'),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Precio: \$', style: TextStyle(fontSize: 18)),
                            Text(
                              fPrecio.format(auto['precio']),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.trashCan),
                              Text('Borrar'),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            provider.autosBorrar(widget.patente);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
