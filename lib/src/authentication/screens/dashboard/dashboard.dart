//@dart = 2.19

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final idBar = TextEditingController();

  final nombreBar = TextEditingController();

  var fecha = DateFormat.yMEd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idBar.text = args["idBar"];
    nombreBar.text = args["nombreBar"];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Dashboard de ' + nombreBar.text,
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('bares')
                  .doc(idBar.text)
                  .collection('ventas')
                  .orderBy('cantidad')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List itemsCant = snapshot.data!.docs.map((e) {
                  return {
                    'domain': e.data()['nombre'],
                    'measure': e.data()['cantidad'],
                  };
                }).toList();

                //itemsCant.sort((a, b) => a['domain'].compareTo(b['domain']));

                List itemsTotal = snapshot.data!.docs.map((e) {
                  return {
                    'domain': e.data()['nombre'],
                    'measure': e.data()['total'],
                  };
                }).toList();
                //itemsTotal.sort((a, b) => a['domain'].compareTo(b['domain']));

                return Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: DChartBar(
                        xAxisTitle: 'Cantidad de cervezas vendidas',
                        data: [
                          {
                            'data': itemsCant,
                          },
                        ],
                        domainLabelPaddingToAxisLine: 16,
                        axisLineTick: 2,
                        axisLinePointTick: 2,
                        axisLinePointWidth: 10,
                        axisLineColor: Colors.blue,
                        measureLabelPaddingToAxisLine: 16,
                        barColor: (barData, index, id) => Colors.blue,
                        showBarValue: true,
                        showDomainLine: true,
                        barValuePosition: BarValuePosition.inside,
                        barValue: (barData, index) => '${barData['measure']}',
                        barValueFontSize: 12,
                        barValueColor: Colors.white,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: DChartBar(
                        xAxisTitle: 'Total vendido',
                        data: [
                          {
                            'id': 'Bar',
                            'data': itemsTotal,
                          },
                        ],
                        domainLabelPaddingToAxisLine: 16,
                        axisLineTick: 2,
                        axisLinePointTick: 2,
                        axisLinePointWidth: 10,
                        axisLineColor: Colors.blue,
                        measureLabelPaddingToAxisLine: 16,
                        barColor: (barData, index, id) => Colors.blue,
                        showBarValue: true,
                        showDomainLine: true,
                        barValuePosition: BarValuePosition.inside,
                        barValue: (barData, index) => '${barData['measure']}',
                        barValueFontSize: 12,
                        barValueColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          //AGREGAR DATE PICKER QUE LLEVE A OTRA SCREEN CON LOS GRAFICOS DE ESE DIA Y DEJAR ESTE COMO TOTAL GENERAL
                          DateTime? fechaSelecc = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100));
                          if (fechaSelecc != null) {
                            String formatDate =
                                DateFormat.yMEd().format(fechaSelecc);

                            setState(() {
                              fecha = formatDate;
                            });
                          }

                          Navigator.pushNamed(context, '/reporteFecha',
                              arguments: {
                                'fecha': fecha,
                                'idBar': idBar.text,
                                'nombreBar': nombreBar.text,
                              });
                        },
                        child: Text('Seleccionar fecha'))
                  ],
                );
              },
            ),
          ],
        ));
  }
}
