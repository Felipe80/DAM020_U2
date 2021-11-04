import 'package:flutter/material.dart';
import 'package:u2_dpa_301/provider/dpa_provider.dart';

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
        title: Text('App DPA'),
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
                    return Text('Cargando...');
                  }
                  return DropdownButton<String>(
                    value: region.isEmpty ? null : region,
                    isExpanded: true,
                    hint: Text('Region'),
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
                },
              ),
            ),

            //PROVINCIA
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder(
                future: provider.getProvincias(region),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Cargando...');
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder(
                future: provider.getComunas(region, provincia),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Cargando...');
                  }
                  return DropdownButton<String>(
                    value: comuna.isEmpty ? null : comuna,
                    isExpanded: true,
                    hint: Text('Comuna'),
                    items:
                        snapshot.data.map<DropdownMenuItem<String>>((comuna) {
                      return DropdownMenuItem<String>(
                        child: Text(comuna['nombre']),
                        value: comuna['codigo'],
                      );
                    }).toList(),
                    onChanged: (nuevaComuna) {
                      setState(() {
                        comuna = nuevaComuna.toString();
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
