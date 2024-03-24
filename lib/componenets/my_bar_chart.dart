import 'package:demo_google/models/my_bar.dart';
import 'package:demo_google/repositories/bar_chart_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatelessWidget {
  final double starting;
  final List<double> data;
  const MyBarChart({super.key, required this.starting, required this.data});

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    List<MyBar> barPointList =
        BarChartRepository().getStockPointList(yList: data);

    return BarChart(
      BarChartData(
        borderData: FlBorderData(
            border: Border(top: BorderSide.none, right: BorderSide.none)),
        titlesData: FlTitlesData(
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: barPointList
            .map((e) => BarChartGroupData(x: e.x, barRods: [
                  BarChartRodData(
                      toY: e.y,
                      fromY: starting,
                      color: Colors.black,
                      width: mWidth*0.02546,
                      borderRadius: BorderRadius.circular(4))
                ]))
            .toList(),
      ),
    );
  }
}
