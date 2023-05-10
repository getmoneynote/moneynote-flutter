import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/charts/index.dart';
import 'index.dart';

class DebtSheet extends StatefulWidget {

  const DebtSheet({super.key});

  @override
  State<DebtSheet> createState() => _DebtSheetState();
}

class _DebtSheetState extends State<DebtSheet> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartBalanceBloc, ChartBalanceState>(
        builder: (context, state) {
          if (state.status == LoadDataStatus.success) {
            if (state.data[1].isEmpty) {
              return const Empty();
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildChart(state.data[1]),
                  const SizedBox(height: 10),
                  CircularLegend(xys: state.data[1])
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
      title: ChartTitle(text: '负债分类'),
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
                Text(removeDecimalZero(calChartTotal(data)), style: const TextStyle(color: Colors.black, fontSize: 18))
              ],
            )
        )
      ],
    );
  }

}
