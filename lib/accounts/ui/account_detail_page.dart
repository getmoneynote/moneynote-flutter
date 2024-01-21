import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/accounts/index.dart';
import '/login/index.dart';

class AccountDetailPage extends StatefulWidget {

  final int id;

  const AccountDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();

}

class _AccountDetailPageState extends State<AccountDetailPage> {

  late String groupCurrencyCode;

  @override
  void initState() {
    super.initState();
    groupCurrencyCode = context.read<AuthBloc>().state.initState['group']['defaultCurrencyCode'];
  }

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: '账户详情',
      prefix: 'accounts',
      id: widget.id,
      buildContent: (DetailPageState state) {
        return _buildBody(context, state);
      },
      onEditPressed: (Map<String, dynamic> item) {
        fullDialog(context, AccountFormPage(action: 2, type: item['type'], currentRow: item));
      },
      onDeletePressed: (_) {
        BlocProvider.of<DetailPageBloc>(context).add(DetailPageDeleted());
      },
    );
  }

  Widget _buildBody(BuildContext context, DetailPageState state) {
    if (state.prefix != 'accounts') {
      return const LoadingPage();
    }
    Map<String, dynamic> item = state.item;
    return ContentPage(
      child: Column(
          children: [
            DetailItem(label: '账户类型：', value: item['typeName']),
            DetailItem(label: '账户名称：', value: item['name'], space: false),
            DetailItem(
              label: '余额：',
              value: item['balance'].toStringAsFixed(2),
              tail: TextButton(
                  child: const Text('余额调整'),
                  onPressed: () {
                    fullDialog(context, AccountAdjustPage(action: 1, currentRow: item));
                  }
              ),
              space: false,
            ),
            DetailItem(label: '币种：', value: item['currencyCode']),
            if (item['currencyCode'] != groupCurrencyCode) ...[
              DetailItem(label: '折合$groupCurrencyCode：', value: item['convertedBalance'].toStringAsFixed(2)),
              DetailItem(label: '汇率：', value: item['rate'].toString()),
            ],
            if (item['type'] == 'CREDIT' || item['type'] == 'DEBT') ...[
              DetailItem(label: '额度：', value: item['creditLimit']?.toStringAsFixed(2)),
              DetailItem(label: '剩余额度：', value: item['remainLimit']?.toStringAsFixed(2)),
            ],
            if (item['type'] == 'CREDIT') DetailItem(label: '账单日：', value: item['billDay']?.toString()),
            if (item['type'] == 'DEBT') DetailItem(label: '还款日：', value: item['billDay']?.toString()),
            if (item['type'] == 'DEBT') DetailItem(label: '年化利率(%)：', value: item['apr']?.toString()),
            DetailItem(label: '是否可用：', value: boolToString(item['enable'])),
            DetailItem(label: '是否计入净资产：', value: boolToString(item['include'])),
            DetailItem(label: '是否可支出：', value: boolToString(item['canExpense'])),
            DetailItem(label: '是否可收入：', value: boolToString(item['canIncome'])),
            DetailItem(label: '是否可转入：', value: boolToString(item['canTransferTo'])),
            DetailItem(
                label: '是否可转出：',
                value: boolToString(item['canTransferFrom']),
                space: !(item['no'] != null && item['no'].toString().isNotEmpty)
            ),
            (item['no'] != null && item['no'].toString().isNotEmpty) ?
            DetailItem(
                label: '卡号：',
                value: item['no'],
                tail: TextButton(
                    child: const Text('复制卡号'),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: item['no'])).then((_) => Message.success('卡号复制成功'));
                    }
                ),
                space: false
            ) :
            DetailItem(label: '卡号：', value: item['no']),
            DetailItem(label: '备注：', value: item['notes'], crossAlign: CrossAxisAlignment.start),
            ToggleButton(
                enable: item['enable'],
                onPressed: () {
                  BlocProvider.of<DetailPageBloc>(context).add(DetailPageToggled());
                }
            )
          ],
        )
    );
  }

}
