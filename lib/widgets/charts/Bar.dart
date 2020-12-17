import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatefulWidget {
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  List<charts.Series> seriesList = [];

  @override
  Widget build(BuildContext context) {
    final data = [
      new LinearSales("35 องศา", 5),
      new LinearSales("37 องศา", 2),
      new LinearSales("40 องศา", 10),
    ];

    final data2 = [
      new LinearSales("35 องศา", 20),
      new LinearSales("37 องศา", 5),
      new LinearSales("40 องศา", 15),
    ];

    List<charts.Series<LinearSales, String>> _mySeries = [
      new charts.Series<LinearSales, String>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.temp,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          labelAccessorFn: (LinearSales sales, _) =>
              '\$${sales.sales.toString()}'),
      new charts.Series<LinearSales, String>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.temp,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data2,
          labelAccessorFn: (LinearSales sales, _) =>
              '\$${sales.sales.toString()}'),
    ];

    return charts.BarChart(
      _mySeries,
      animate: true,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(),
    );
  }
}

class LinearSales {
  final String temp;
  final int sales;

  LinearSales(this.temp, this.sales);
}
