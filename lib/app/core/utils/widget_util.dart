import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<DoughnutSeries<Map<String, dynamic>, String>> getDefaultDoughnutSeries(xys) {
  return [
    DoughnutSeries<Map<String, dynamic>, String>(
      radius: '80%',
      innerRadius: '70%',
      dataSource: xys,
      xValueMapper: (data, _) => data['x'],
      yValueMapper: (data, _) => data['y'],
      dataLabelMapper: (data, _) => "${data['x']} : ${data['percent']}%",
      dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(fontSize: 10),
          labelPosition: ChartDataLabelPosition.outside
      ),
      legendIconType: LegendIconType.circle,
    )
  ];
}

num calChartTotal(List<Map<String, dynamic>> data) {
  num total = data.fold(0, (previousValue, element) => previousValue + element['y']*100);
  // 解决精度问题
  return total / 100;
}