import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:u2_monedas_301/providers/moneda_provider.dart';

class TabMonedas extends StatefulWidget {
  TabMonedas({Key? key}) : super(key: key);

  @override
  _TabMonedasState createState() => _TabMonedasState();
}

class _TabMonedasState extends State<TabMonedas> {
  MonedaProvider provider = new MonedaProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            child: Text(
              'Listado de Monedas',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: provider.getMonedas(),
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
                      return ListTile(
                        leading: Icon(MdiIcons.cash),
                        title: Text(snapshot.data[index]['Codigo']),
                        subtitle: Text(snapshot.data[index]['Nombre']),
                        trailing: Text('${snapshot.data[index]['Valor']} CLP'),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
