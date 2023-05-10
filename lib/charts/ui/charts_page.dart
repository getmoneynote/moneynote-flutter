import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/charts/index.dart';
import 'widgets/index.dart';

class ChartsPage extends StatefulWidget {

  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();

}

class _ChartsPageState extends State<ChartsPage> with TickerProviderStateMixin {

  int tabIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: tabIndex, length: 4, vsync: this);
    tabController.addListener(() {
      if(!tabController.indexIsChanging) {
        setState(() {
          tabIndex = tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (tabIndex == 0) {
                  BlocProvider.of<ChartExpenseCategoryBloc>(context).add(ChartExpenseCategoryReloaded());
                }
                if (tabIndex == 1) {
                  BlocProvider.of<ChartIncomeCategoryBloc>(context).add(ChartIncomeCategoryReloaded());
                }
                if (tabIndex == 2 || tabIndex == 3) {
                  BlocProvider.of<ChartBalanceBloc>(context).add(ChartBalanceReloaded());
                }
              },
              icon: const Icon(Icons.refresh)
          ),
          title: TabBar(
            controller: tabController,
            labelPadding: const EdgeInsets.all(0),
            tabs: const [
              Tab(child: Text('支出')),
              Tab(child: Text('收入')),
              Tab(child: Text('资产')),
              Tab(child: Text('负债')),
            ],
          ),
          actions: [
            IconButton(
              onPressed: (tabIndex == 2 || tabIndex == 3) ? null : () {
                if (tabIndex == 0) {
                  fullDialog(context, const ChartExpenseFilterPage());
                } else if (tabIndex == 1) {
                  fullDialog(context, const ChartIncomeFilterPage());
                }
              },
              icon: const Icon(Icons.search)
            )
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            ExpenseCategory(),
            IncomeCategory(),
            AssetSheet(),
            DebtSheet(),
          ]
        )
    );
  }

}
