//@dart = 2.19

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class ReporteFechaScreen extends StatefulWidget {
  ReporteFechaScreen({super.key});

  @override
  State<ReporteFechaScreen> createState() => _ReporteFechaScreen();
}

class _ReporteFechaScreen extends State<ReporteFechaScreen> {
  final idBar = TextEditingController();
  final fechaR = TextEditingController();
  final nombreBar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idBar.text = args["idBar"];
    nombreBar.text = args["nombreBar"];
    fechaR.text = args["fecha"];

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
                  .where('fecha', isEqualTo: fechaR.text)
                  .orderBy('total')
                  .snapshots(includeMetadataChanges: true),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List ventas = snapshot.data!.docs;
                double totalVentas = 0;

                for (var v in ventas) {
                  totalVentas += double.tryParse(v['total'].toString()) ?? 0;
                }
                List items = snapshot.data!.docs.map((e) {
                  return {
                    'domain': e.data()['fecha'],
                    'measure': totalVentas,
                  };
                }).toList();

                //items.sort((a, b) => a['domain'].compareTo(b['domain']));

                return Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 8 / 6,
                      child: DChartBar(
                        xAxisTitle: 'Total vendido por día',
                        data: [
                          {
                            'id': 'Bar',
                            'data': items,
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
                  ],
                );
              },
            ),
          ],
        ));
  }
}
