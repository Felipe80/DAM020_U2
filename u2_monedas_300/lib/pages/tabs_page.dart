import 'package:flutter/material.dart';
import 'package:u2_monedas_300/pages/tab_calculadora.dart';
import 'package:u2_monedas_300/pages/tab_monedas.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Monedas'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Monedas',
              ),
              Tab(
                text: 'Calculadora',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [TabMonedas(), TabCalculadora()],
        ),
      ),
    );
  }
}
