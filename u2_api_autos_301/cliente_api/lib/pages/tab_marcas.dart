import 'package:cliente_api/pages/marcas_agregar.dart';
import 'package:cliente_api/pages/marcas_editar.dart';
import 'package:cliente_api/provider/autos_provider.dart';
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
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: provider.getMarcas(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                separatorBuilder: (_, __) => Divider(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: ListTile(
                      leading: Icon(MdiIcons.car),
                      title: Text(snapshot.data[index]['nombre']),
                    ),
                    actions: [
                      IconSlideAction(
                        caption: 'Editar',
                        color: Colors.purple,
                        icon: MdiIcons.pen,
                        onTap: () {
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
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Borrar',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          confirmDialog(context, snapshot.data[index]['nombre'])
                              .then((confirma) {
                            if (confirma) {
                              var nombre = snapshot.data[index]['nombre'];
                              setState(() {
                                provider
                                    .marcaBorrar(snapshot.data[index]['id'])
                                    .then((borradoExitoso) {
                                  if (!borradoExitoso) {
                                    //error
                                    _showSnackbar('Ha ocurrido un problema :(');
                                  } else {
                                    //borrado ok
                                    _showSnackbar('Marca $nombre borrada');
                                  }
                                });
                                snapshot.data.removeAt(index);
                              });
                            }
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          child: ElevatedButton(
            child: Text('Agregar Marca'),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                return MarcasAgregar();
              });
              Navigator.push(context, route).then((value) {
                setState(() {});
              });
            },
          ),
        ),
      ],
    );
  }

  void _showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(mensaje),
    ));
  }

  Future<dynamic> confirmDialog(BuildContext context, String marca) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmar borrado de marca'),
            content: Text('¿Confirma borrar la marca $marca?'),
            actions: [
              TextButton(
                child: Text('CANCELAR'),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('ACEPTAR'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }
}
