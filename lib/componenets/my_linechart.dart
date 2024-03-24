import 'package:demo_google/models/graph_point.dart';
import 'package:demo_google/repositories/graph_point_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyLineChart extends StatelessWidget {
  final List<double> yList;
  final bool data;
  const MyLineChart({super.key, required this.yList, required this.data});

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    List<GraphPoint> graphPointList =
        GraphPointRepository().getGraphPointList(graphY: yList);
    return LineChart(LineChartData(
        titlesData: FlTitlesData(
          show: data, 
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData:
            FlGridData(drawVerticalLine: false, drawHorizontalLine: false),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(
              spots: graphPointList
                  .map((point) => FlSpot(point.x, point.y))
                  .toList(),
              isCurved: false,
              dotData: FlDotData(show: false),
              color: Colors.green,
              barWidth: mWidth*0.002546,
              belowBarData: BarAreaData(
                  show: true, color: Colors.green.shade50.withOpacity(0.4)))
        ]));
  }
}
