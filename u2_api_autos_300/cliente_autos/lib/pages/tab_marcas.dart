import 'package:cliente_autos/provider/autos_provider.dart';
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
    return Container(
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
              return ListTile(
                leading: Icon(MdiIcons.car),
                title: Text(snapshot.data[index]['nombre']),
              );
            },
          );
        },
      ),
    );
  }
}
