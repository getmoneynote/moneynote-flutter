import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/charts/index.dart';
import 'index.dart';

class AssetSheet extends StatefulWidget {

  const AssetSheet({super.key});

  @override
  State<AssetSheet> createState() => _AssetSheetState();
}

class _AssetSheetState extends State<AssetSheet> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartBalanceBloc, ChartBalanceState>(
      builder: (context, state) {
        if (state.status == LoadDataStatus.success) {
          if (state.data[0].isEmpty) {
            return const Empty();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildChart(state.data[0]),
                const SizedBox(height: 10),
                CircularLegend(xys: state.data[0])
              ],
            ),
          );
        }
        return const LoadingPage();
      }
    );
  }

  Widget _buildChart(List<Map<String, dynamic>> data) {
    Map<String, double> dataMap = { };
    for (var e in data) {
      dataMap[e['x']] = e['y'];
    }
    return SfCircularChart(
      title: ChartTitle(text: '资产分类'),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: getDefaultDoughnutSeries(data),
      annotations: [
        CircularChartAnnotation(
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('总金额', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(calChartTotal(data).toStringAsFixed(2), style: const TextStyle(color: Colors.black, fontSize: 18))
              ],
            )
        )
      ],
    );
  }

}
