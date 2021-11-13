import 'package:cliente_autos/pages/marcas_agregar.dart';
import 'package:cliente_autos/pages/marcas_editar.dart';
import 'package:cliente_autos/provider/autos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabMarcas extends StatefulWidget {
  TabMarcas({Key? key}) : super(key: key);

  @override
  _TabMarcasState createState() => _TabMarcasState();
}

class _TabMarcasState extends State<TabMarcas> {
  AutosProvider provider = AutosProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: provider.getMarcas(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      child: ListTile(
                        leading: Icon(MdiIcons.car),
                        title: Text(snapshot.data[index]['nombre']),
                      ),
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (context) => MarcasEditar(
                                  id: snapshot.data[index]['id'],
                                  nombre: snapshot.data[index]['nombre'],
                                ),
                              );
                              Navigator.push(context, route).then((value) {
                                setState(() {});
                              });
                            },
                            backgroundColor: Colors.purple,
                            icon: MdiIcons.pen,
                            label: 'Editar',
                          )
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              var nombre = snapshot.data[index]['nombre'];
                              setState(() {
                                provider
                                    .marcaBorrar(snapshot.data[index]['id'])
                                    .then((borradoExitoso) {
                                  if (!borradoExitoso) {
                                    showSnackbar('Ha ocurrido un problema');
                                  } else {
                                    showSnackbar('Marca $nombre borrada');
                                    snapshot.data.removeAt(index);
                                  }
                                });
                              });
                            },
                            backgroundColor: Colors.red,
                            icon: MdiIcons.trashCan,
                            label: 'Borrar',
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Text('Agregar Marca'),
              onPressed: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => MarcasAgregar());
                Navigator.push(context, route).then((value) {
                  setState(() {});
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }
}
