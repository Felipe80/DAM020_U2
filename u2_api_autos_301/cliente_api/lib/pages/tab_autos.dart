import 'package:cliente_api/pages/autos_agregar.dart';
import 'package:cliente_api/pages/autos_detalle.dart';
import 'package:cliente_api/provider/autos_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabAutos extends StatefulWidget {
  TabAutos({Key? key}) : super(key: key);

  @override
  _TabAutosState createState() => _TabAutosState();
}

class _TabAutosState extends State<TabAutos> {
  AutosProvider provider = AutosProvider();
  var fPrecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: provider.getAutos(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return DataTable(
                columnSpacing: 10,
                columns: [
                  DataColumn(label: Text('Detalle')),
                  DataColumn(label: Text('Auto')),
                  DataColumn(label: Text('Precio'), numeric: true),
                ],
                rows: snapshot.data.map<DataRow>((auto) {
                  return DataRow(
                    cells: [
                      DataCell(
                        OutlinedButton(
                          child: Icon(
                            MdiIcons.carInfo,
                            color: Colors.purple,
                          ),
                          onPressed: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => AutosDetalle(
                                patente: auto['patente'],
                              ),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      ),
                      DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(auto['patente'],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                '${auto['marca'] == null ? 'Sin marca' : auto['marca']['nombre']} ${auto['modelo']}'),
                          ],
                        ),
                      ),
                      DataCell(Text('\$' + fPrecio.format(auto['precio']))),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => AutosAgregar(),
          );
          Navigator.push(context, route).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
