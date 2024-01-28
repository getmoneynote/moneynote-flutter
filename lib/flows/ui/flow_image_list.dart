import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:moneywhere/flows/data/flow_repository.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/flows/bloc/flow_image/flow_image_bloc.dart';

class FlowsImageList extends StatefulWidget {

  final int id;

  const FlowsImageList({
    super.key,
    required this.id,
  });

  @override
  State<FlowsImageList> createState() => _FlowsImageListState();

}

class _FlowsImageListState extends State<FlowsImageList> {

  @override
  void initState() {
    BlocProvider.of<FlowImageBloc>(context).add(FlowImageReloaded(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FlowImageBloc, FlowImageState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              BlocProvider.of<FlowImageBloc>(context).add(FlowImageReloaded(widget.id));
            }
          }
        ),
        BlocListener<FlowImageBloc, FlowImageState>(
          listenWhen: (previous, current) => previous.uploadStatus != current.uploadStatus,
          listener: (context, state) {
            if (state.uploadStatus == LoadDataStatus.success) {
              Message.success('上传成功');
              EasyLoading.dismiss();
              BlocProvider.of<FlowImageBloc>(context).add(FlowImageReloaded(widget.id));
            } else if (state.uploadStatus == LoadDataStatus.failure) {
              Message.error('上传失败');
              EasyLoading.dismiss();
            } else if (state.uploadStatus == LoadDataStatus.progress) {
              EasyLoading.show(status: '上传中...');
            }
          }
        )
      ],
      child: BlocBuilder<FlowImageBloc, FlowImageState>(
        buildWhen: (previous, current) => previous.items != current.items,
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const SizedBox.shrink();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: Center(
                    child: Text('文件：', style: Theme.of(context).textTheme.bodyMedium)
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.items.map((e) => (
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  if (e['contentType'] == 'application/pdf') {
                                    Message.error('PDF不支持预览，复制地址之后，使用浏览器打开。');
                                    return;
                                  }
                                  navigateTo(context, WebViewPage(title: '账单文件', url: FlowRepository.buildUrl(e)));
                                },
                                child: Text(e['originalName']),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: FlowRepository.buildUrl(e))).then((_) => Message.success('复制成功')
                              );
                            },
                            child: const Text('复制地址'),
                          ),
                          DialogConfirm(
                              content: '确定删除吗？',
                              child: AbsorbPointer(
                                child: TextButton(
                                  onPressed: () { },
                                  child: const Text('删除'),
                                ),
                              ),
                              onConfirm: () {
                                BlocProvider.of<FlowImageBloc>(context).add(FlowImageDeleted(e['id']));
                              }
                          ),
                        ],
                      ))).toList(),
                )
              ),
            ]);
        }),
    );
  }
}
