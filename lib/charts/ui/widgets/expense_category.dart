import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/login/index.dart';
import '/charts/index.dart';
import 'index.dart';

class ExpenseCategory extends StatefulWidget {

  const ExpenseCategory({super.key});

  @override
  State<ExpenseCategory> createState() => _ExpenseCategoryState();

}

class _ExpenseCategoryState extends State<ExpenseCategory> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChartExpenseCategoryBloc>(context).add(ChartExpenseCategoryInitial(
      query: {'bookId': context.read<AuthBloc>().state.initState['book']['id']},
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartExpenseCategoryBloc, ChartExpenseCategoryState>(
        builder: (context, state) {
          if (state.status == LoadDataStatus.success) {
            if (state.data.isEmpty) {
              return const Empty();
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildChart(state.data),
                  const SizedBox(height: 10),
                  CircularLegend(xys: state.data)
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
      title: ChartTitle(text: '支出分类'),
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
