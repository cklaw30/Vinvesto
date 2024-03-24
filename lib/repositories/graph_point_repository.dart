import 'package:demo_google/models/graph_point.dart';
import 'package:collection/collection.dart';

class GraphPointRepository {
  List<GraphPoint> getGraphPointList({required List<double> graphY}) {
    final data = graphY;
    return data.mapIndexed((index, element) => GraphPoint(x: index.toDouble(), y: element)).toList();
  }
}