import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:u2_monedas_301/providers/moneda_provider.dart';

class TabCalculadora extends StatefulWidget {
  TabCalculadora({Key? key}) : super(key: key);

  @override
  _TabCalculadoraState createState() => _TabCalculadoraState();
}

class _TabCalculadoraState extends State<TabCalculadora> {
  MonedaProvider provider = new MonedaProvider();
  String monedaSeleccionada = 'UF';
  TextEditingController montoCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          TextField(
            controller: montoCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Monto CLP',
              hintText: 'Cantidad de dinero en Peso Chileno',
              suffixIcon: Icon(MdiIcons.cash),
            ),
          ),
          FutureBuilder(
            future: provider.getMonedas(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                width: double.infinity,
                child: DropdownButton(
                  value: monedaSeleccionada,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      monedaSeleccionada = value.toString();
                    });
                  },
                  hint: Text('Moneda de destino'),
                  items: snapshot.data.map<DropdownMenuItem<String>>((moneda) {
                    return DropdownMenuItem<String>(
                      child: Text('(${moneda['Codigo']}) ${moneda['Nombre']}'),
                      value: moneda['Codigo'],
                    );
                  }).toList(),
                ),
              );
            },
          ),
          Spacer(),
          Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Calcular'),
                onPressed: () async {
                  int montoClp = int.parse(montoCtrl.text);
                  double valorMonedaSeleccionada =
                      await provider.getValorMoneda(monedaSeleccionada);
                  double resultado =
                      roundDouble(montoClp / valorMonedaSeleccionada, 2);
                  // print(resultado);

                  FocusScope.of(context).unfocus();

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Resultado'),
                      content: Text('$resultado ($monedaSeleccionada)'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places).toDouble();
    return ((value * mod).round().toDouble() / mod);
  }
}
