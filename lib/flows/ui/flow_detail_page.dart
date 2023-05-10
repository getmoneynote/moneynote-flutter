import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/accounts/index.dart';
import '/flows/index.dart';

class FlowDetailPage extends StatelessWidget {

  const FlowDetailPage({super.key, required this.id,});

  final int id;

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: '账单详情',
      prefix: 'balance-flows',
      id: id,
      buildContent: (DetailPageState state) {
        return _buildBody(context, state);
      },
      onEditPressed: (Map<String, dynamic> item) {
        if (item['type'] == 'ADJUST') {
          fullDialog(context, AccountAdjustPage(action: 2, currentRow: item));
        } else {
          fullDialog(context, FlowFormPage(action: 2, currentRow: item));
        }
      },
      onDeletePressed: (_) {
        BlocProvider.of<DetailPageBloc>(context).add(DetailPageDeleted());
      },
    );
  }

  Widget _buildBody(BuildContext context, DetailPageState state) {
    if (state.prefix != 'balance-flows') {
      return const LoadingPage();
    }
    Map<String, dynamic> item = state.item;
    return ContentPage(
        child: Column(
          children: [
            if (item['type'] != 'ADJUST') _buildActionBar(context, item),
            if (item['type'] != 'ADJUST') const SizedBox(height: 15),
            DetailItem(label: '所属账本：', value: item['book']['name']),
            DetailItem(label: '交易类型：', value: item['typeName']),
            DetailItem(label: '标题：', value: item['title']),
            DetailItem(label: '时间：', value: dateTimeFormat(item['createTime'])),
            DetailItem(label: '金额：', value: item['amount'].toStringAsFixed(2)),
            if (item['needConvert'])
              DetailItem(label: '折合${item['convertCode']}：', value: item['convertedAmount'].toStringAsFixed(2)),
            DetailItem(label: '账户：', value: item['accountName']),
            if (item['categoryName']?.isNotEmpty ?? false)
              DetailItem(label: '类别：', value: item['categoryName']),
            if (item['type'] != 'ADJUST') DetailItem(label: '标签：', value: item['tagsName']),
            if (item['type'] != 'ADJUST') DetailItem(label: '交易对象：', value: item['payee']?['name']),
            if (item['type'] != 'ADJUST') DetailItem(label: '是否确认：', value: boolToString(item['confirm'])),
            if (item['type'] != 'ADJUST') DetailItem(label: '是否统计：', value: boolToString(item['include'])),
            DetailItem(label: '备注：', value: item['notes'], crossAlign: CrossAxisAlignment.start),
          ],
        )
    );
  }

  Widget _buildActionBar(BuildContext context, Map<String, dynamic> item) {
    return OverflowBar(
      overflowAlignment: OverflowBarAlignment.center,
      spacing: 15,
      children: [
        ElevatedButton(
          onPressed: () {
            fullDialog(context, FlowFormPage(action: 3, currentRow: item));
          },
          child: const Text('复制')
        ),
        ElevatedButton(
          onPressed: () {
            fullDialog(context, FlowFormPage(action: 4, currentRow: item));
          },
          child: const Text('退款')
        ),
        DialogConfirm(
          content: '此操作会更新账户余额，确认此操作吗？',
          enable: item['confirm'] != null && !item['confirm'],
          child: AbsorbPointer(
            child: ElevatedButton(
              onPressed: (item['confirm'] != null && !item['confirm']) ? () { } : null,
              child: const Text('确认'),
            ),
          ),
          onConfirm: () {
            BlocProvider.of<SimpleActionBloc>(context).add(SimpleActionReloaded(uri: "balance-flows/${item['id']}/confirm"));
          }
        ),
      ],
    );
  }

}
