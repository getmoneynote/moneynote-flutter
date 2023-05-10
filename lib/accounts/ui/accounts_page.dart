import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/accounts/index.dart';

class AccountsPage extends StatefulWidget {

  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();

}

// https://stackoverflow.com/questions/68013459/how-to-use-multiple-tab-for-single-page-in-flutter
class _AccountsPageState extends State<AccountsPage> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if(!tabController.indexIsChanging) {
        BlocProvider.of<ListPageBloc>(context).add(ListPageQueryChanged({
          'type': accountTabIndexToType(tabController.index)
        }));
        BlocProvider.of<ListPageBloc>(context).add(ListPageReloaded());
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<ListPageBloc>(context).add(ListPageReloaded());
          },
          icon: const Icon(Icons.refresh)
        ),
        centerTitle: true,
        title: TabBar(
          controller: tabController,
          labelPadding: const EdgeInsets.all(0),
          tabs: const [
            Tab(child: Text('活期', softWrap: false)),
            Tab(child: Text('信用', softWrap: false)),
            Tab(child: Text('资产', softWrap: false)),
            Tab(child: Text('贷款', softWrap: false)),
          ],
        ),
        actions: [
          const OrderButton(
            items: {
              'balance,desc': '余额排序',
              'enable,desc': '可用优先',
              'canExpense,desc': '可支出优先',
              'canIncome,desc': '可收入优先',
            }
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              fullDialog(context, AccountFormPage(action: 1, type: accountTabIndexToType(tabController.index)));
            }
          )
        ]
      ),
      body: GestureDetector(
        // https://flutterassets.com/flutter-gestures-detection/
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            if (tabController.index > 0) {
              tabController.animateTo(tabController.index - 1);
            }
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            if (tabController.index < 3) {
              tabController.animateTo(tabController.index + 1);
            }
          }
        },
        child: ListPage(
          prefix: 'accounts',
          query: const {'type': 'CHECKING'},
          buildContent: (ListPageState state) {
            return _buildBody(context, state);
          },
        ),
      )
    );
  }

  Widget _buildBody(BuildContext context, ListPageState state) {
    if (state.prefix != 'accounts') {
      return const LoadingPage();
    }
    List<Map<String, dynamic>> items = state.items;
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = items.elementAt(index);
        return ListTile(
          dense: true,
          title: Text(item['name'], style: theme.textTheme.bodyLarge),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item['balance'].toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
              const Icon(Icons.keyboard_arrow_right)
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AccountDetailPage(id: item['id']),
              ),
            );
          },
          onLongPress: () {
            fullDialog(context, AccountAdjustPage(action: 1, currentRow: item));
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

}