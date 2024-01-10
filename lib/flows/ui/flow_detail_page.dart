import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/accounts/index.dart';
import '/flows/index.dart';
import 'flow_image_list.dart';


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
      // onDeletePressed: (_) {
      //   BlocProvider.of<DetailPageBloc>(context).add(DetailPageDeleted());
      // },
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
            FlowsImageList(id: id)
          ],
        )
    );
  }

  Widget _buildActionBar(BuildContext context, Map<String, dynamic> item) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            fullDialog(context, FlowFormPage(action: 3, currentRow: item));
          },
          icon: const Icon(Icons.copy, size: 15,),
          label: const Text('复制'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            fullDialog(context, FlowFormPage(action: 4, currentRow: item));
          },
          icon: const Icon(Icons.undo, size: 15,),
          label: const Text('退款')
        ),
        DialogConfirm(
          content: '此操作会更新账户余额，确认此操作吗？',
          enable: item['confirm'] != null && !item['confirm'],
          child: AbsorbPointer(
            child: ElevatedButton.icon(
              onPressed: (item['confirm'] != null && !item['confirm']) ? () { } : null,
              icon: const Icon(Icons.done, size: 15,),
              label: const Text('确认'),
            ),
          ),
          onConfirm: () {
            BlocProvider.of<SimpleActionBloc>(context).add(SimpleActionReloaded(uri: "balance-flows/${item['id']}/confirm"));
          }
        ),
        DialogConfirm(
          content: item['confirm'] ? '此操作会更新账户余额，确认此操作吗？' : '删除之后无法恢复，确定删除吗？',
          child: AbsorbPointer(
            child: ElevatedButton.icon(
              onPressed: () {  },
              icon: const Icon(Icons.delete, size: 15,),
              label: const Text('删除'),
            ),
          ),
          onConfirm: () {
            BlocProvider.of<DetailPageBloc>(context).add(DetailPageDeleted());
          }
        ),
        ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text('拍照'),
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                          if (photo != null) {
                            BlocProvider.of<FlowImageBloc>(context).add(FlowImageUploaded(id, photo.path));
                          }
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('图片库'),
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                          if (file != null) {
                            BlocProvider.of<FlowImageBloc>(context).add(FlowImageUploaded(id, file.path));
                          }
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.cancel),
                        title: const Text('取消'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          },
          icon: const Icon(Icons.attachment, size: 15,),
          label: const Text('文件')
        ),
      ],
    );
  }

}
