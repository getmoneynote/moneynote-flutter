import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/accounts/index.dart';
import '/flows/index.dart';
import '/charts/index.dart';
import '/my/index.dart';

class IndexPage extends StatefulWidget {

  final int initialIndex;

  const IndexPage({
    super.key,
    this.initialIndex = 1,
  });

  @override
  State<IndexPage> createState() => _IndexPageState();

}

class _IndexPageState extends State<IndexPage> {

  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  Widget buildBottomItem(int index, IconData iconData, String label) {
    final theme = Theme.of(context);
    Color color = _selectedIndex == index ? theme.primaryColor : theme.unselectedWidgetColor;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: SizedBox(
        width: 66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: color),
            Text(label, style: TextStyle(color: color))
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: LazyIndexedStack(
        reuse: false,
        index: _selectedIndex,
        itemBuilder: (c, i) {
          switch (i) {
            case 0:
              return AccountsPage(
                key: UniqueKey(),
              );
            case 1:
              return FlowsPage(
                key: UniqueKey(),
              );
            case 2:
              return const ChartsPage();
            case 3:
              return const MyPage();
          }
          throw Exception('index page error');
        },
        itemCount: 4,
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: theme.unselectedWidgetColor),
          ),
        ),
        child: Row(
          children: [
            buildBottomItem(0, Icons.account_balance_outlined, AppLocalizations.of(context)!.menuAccounts),
            buildBottomItem(1, Icons.table_rows_outlined, '流水'),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  fullDialog(context, const FlowFormPage(action: 1));
                },
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text('记账', style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.onPrimary)),
                ),
              ),
            ),
            buildBottomItem(2, Icons.pie_chart_outline, '图表'),
            buildBottomItem(3, Icons.person_outline_outlined, '我的'),
          ]
        )
      )
    );
  }
}
