import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:u2_dpa_300/provider/dpa_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DpaProvider provider = DpaProvider();
  String region = '', provincia = '', comuna = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DPA'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            //REGION
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder(
                  future: provider.getRegiones(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Cargando Regiones...');
                    }
                    return DropdownButton<String>(
                      value: region.isEmpty ? null : region,
                      isExpanded: true,
                      hint: Text('Región'),
                      items:
                          snapshot.data.map<DropdownMenuItem<String>>((region) {
                        return DropdownMenuItem<String>(
                          child: Text(region['nombre']),
                          value: region['codigo'],
                        );
                      }).toList(),
                      onChanged: (nuevaRegion) {
                        setState(() {
                          region = nuevaRegion.toString();
                          provincia = '';
                          comuna = '';
                        });
                      },
                    );
                  }),
            ),

            //PROVINCIA
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder(
                future: provider.getProvincias(region),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Cargando Provincias...');
                  }
                  return DropdownButton<String>(
                    value: provincia.isEmpty ? null : provincia,
                    isExpanded: true,
                    hint: Text('Provincia'),
                    items: snapshot.data
                        .map<DropdownMenuItem<String>>((provincia) {
                      return DropdownMenuItem<String>(
                        child: Text(provincia['nombre']),
                        value: provincia['codigo'],
                      );
                    }).toList(),
                    onChanged: (nuevaProvincia) {
                      setState(() {
                        provincia = nuevaProvincia.toString();
                        comuna = '';
                      });
                    },
                  );
                },
              ),
            ),

            //COMUNA
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: FutureBuilder(
                  future: provider.getComunas(region, provincia),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Cargando Comunas...');
                    }
                    return ListView.separated(
                      separatorBuilder: (_, __) => Divider(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListTile(
                          leading: Icon(MdiIcons.homeCityOutline),
                          title: Text(snapshot.data[index]['nombre']),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
