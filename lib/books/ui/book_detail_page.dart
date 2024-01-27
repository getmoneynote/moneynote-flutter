import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';


class BookDetailPage extends StatelessWidget {

  const BookDetailPage({super.key, required this.id,});

  final int id;

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: '账本详情',
      prefix: 'books',
      id: id,
      buildContent: (DetailPageState state) {
        return _buildBody(context, state);
      },
      // onEditPressed: (Map<String, dynamic> item) {
      //   fullDialog(context, FlowFormPage(action: 2, currentRow: item));
      // },
      onDeletePressed: (_) {
        BlocProvider.of<DetailPageBloc>(context).add(DetailPageDeleted());
      },
    );
  }

  Widget _buildBody(BuildContext context, DetailPageState state) {
    if (state.prefix != 'books') {
      return const LoadingPage();
    }
    Map<String, dynamic> item = state.item;
    return ContentPage(
        child: Column(
          children: [
            _buildActionBar(context, item),
            const SizedBox(height: 15),
            DetailItem(label: '账本名称：', value: item['name']),
            DetailItem(label: '币种：', value: item['defaultCurrencyCode']),
            DetailItem(label: '是否可用：', value: boolToString(item['enable'])),
            DetailItem(label: '默认支出账户：', value: item['defaultExpenseAccount']?['name']),
            DetailItem(label: '默认收入账户：', value: item['defaultIncomeAccount']?['name']),
            DetailItem(label: '默认支出类别：', value: item['defaultExpenseCategory']?['name']),
            DetailItem(label: '默认收入类别：', value: item['defaultIncomeCategory']?['name']),
            DetailItem(label: '默认转出账户：', value: item['defaultTransferFromAccount']?['name']),
            DetailItem(label: '默认转入账户：', value: item['defaultTransferToAccount']?['name']),
          ],
        )
    );
  }

  Widget _buildActionBar(BuildContext context, Map<String, dynamic> item) {
    return OverflowBar(
      overflowAlignment: OverflowBarAlignment.center,
      spacing: 15,
      children: [
        DialogConfirm(
          content: '更改默认账本，需要手动重启程序，确认此操作吗？',
          enable: !item['current'],
          child: AbsorbPointer(
            child: ElevatedButton(
              onPressed: (!item['current']) ? () { } : null,
              child: const Text('设为默认'),
            ),
          ),
          onConfirm: () {
            BlocProvider.of<SimpleActionBloc>(context).add(SimpleActionReloaded(uri: "setDefaultBook/${item['id']}"));
            // BlocProvider.of<AuthBloc>(context).add(AppStarted());
          }
        ),
      ],
    );
  }

}
