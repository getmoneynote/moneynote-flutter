import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/login/index.dart';
import '/flows/index.dart';

class FlowsPage extends StatelessWidget {

  const FlowsPage({super.key});

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
        title: const Text("账单列表"),
        centerTitle: true,
        actions: [
          const OrderButton(
            items: {
              'createTime,desc': '按时间排序',
              'amount,desc': '按金额排序',
            }
          ),
          IconButton(
              onPressed: () {
                fullDialog(context, const FlowFilterPage());
              },
              icon: const Icon(Icons.search)
          )
        ],
      ),
      body: ListPage(
        prefix: 'balance-flows',
        // 搜索默认账本下面的账单
        query: {'book': context.read<AuthBloc>().state.initState['book']['id']},
        buildContent: (ListPageState state) {
          return _buildBody(context, state);
        },
      )
    );
  }

  Widget _buildBody(BuildContext context, ListPageState state) {
    if (state.prefix != 'balance-flows') {
      return const LoadingPage();
    }
    List<Map<String, dynamic>> items = state.items;
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = items.elementAt(index);
        TextStyle amountStyle = theme.textTheme.titleLarge ?? const TextStyle(fontWeight: FontWeight.w500, fontSize: 20);
        if (item['type'] == 'EXPENSE') amountStyle = amountStyle.copyWith(color: Colors.green);
        if (item['type'] == 'INCOME') amountStyle = amountStyle.copyWith(color: Colors.red);
        return ListTile(
          dense: true,
          title: Text(item['listTitle'], style: theme.textTheme.bodyLarge),
          subtitle: Text('${item["typeName"]} ${dateFormat(item["createTime"])} ${item["tagsName"]}', style: theme.textTheme.bodySmall),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item['accountName']?.isNotEmpty ?? false)
                Column(
                  children: [
                    Text(item['amount'].toStringAsFixed(2), style: amountStyle),
                    Text(item['accountName'], style: theme.textTheme.bodySmall),
                  ],
                ),
              if (item['accountName']?.isEmpty ?? true)
                Text(item['amount'].toStringAsFixed(2), style: amountStyle),
              const Icon(Icons.keyboard_arrow_right)
            ],
          ),
          onTap: () {
            navigateTo(context, FlowDetailPage(id: item['id']));
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

}