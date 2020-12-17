import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DonutChart extends StatefulWidget {
  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  List<charts.Series> seriesList = [];

  @override
  Widget build(BuildContext context) {
    List jsonData = [
      {"temp": 35, "display": "35 องศา", "value": 35},
      {"temp": 36, "display": "36 องศา", "value": 36},
      {"temp": 38, "display": "38 องศา", "value": 38},
      {"temp": 40, "display": "40 องศา", "value": 40}
    ];

    List<LinearSales> data = [];
    jsonData.forEach((element) {
      data.add(LinearSales(element['display'], element['value']));
    });

    // final data = [
    //   new LinearSales("35 องศา", 5),
    //   new LinearSales("37 องศา", 2),
    //   new LinearSales("40 องศา", 10),
    // ];

    List<charts.Series<LinearSales, String>> _mySeries = [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.temp,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];

    return charts.PieChart(_mySeries,
        animate: true,
        // behaviors: [new charts.SeriesLegend()],
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.outside)
            ]));
  }
}

class LinearSales {
  final String temp;
  final int sales;

  LinearSales(this.temp, this.sales);
}
