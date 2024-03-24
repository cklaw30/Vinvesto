import 'package:demo_google/models/my_bar.dart';
import 'package:collection/collection.dart';

class BarChartRepository {
  List<MyBar> getStockPointList({required List<double> yList}) {
    final data = yList;
    return data.mapIndexed((index, element) => MyBar(x: index+1, y: element)).toList();
  }
}