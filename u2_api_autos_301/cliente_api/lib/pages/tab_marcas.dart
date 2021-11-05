import 'package:cliente_api/pages/marcas_agregar.dart';
import 'package:cliente_api/provider/autos_provider.dart';
import 'package:flutter/material.dart';
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
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ObjectKey(snapshot.data[index]),
                    child: ListTile(
                      leading: Icon(MdiIcons.car),
                      title: Text(snapshot.data[index]['nombre']),
                    ),
                    background: Container(color: Colors.purple),
                    secondaryBackground: Container(
                      padding: EdgeInsets.only(right: 5),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Borrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            MdiIcons.trashCan,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      var nombre = snapshot.data[index]['nombre'];
                      setState(() {
                        provider
                            .marcaBorrar(snapshot.data[index]['id'])
                            .then((borradoExitoso) {
                          if (!borradoExitoso) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Ha ocurrido un problema :('),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text(
                                'Marca $nombre borrada',
                              ),
                            ));
                          }
                        });
                        snapshot.data.removeAt(index);
                      });
                      // if (direction == DismissDirection.startToEnd) {
                      //   print('Hacia derecha');
                      // } else {
                      //   print('Hacia izquierda');
                      // }
                    },
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
}
