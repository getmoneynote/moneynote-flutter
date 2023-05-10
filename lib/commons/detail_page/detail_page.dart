import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';

class DetailPage extends StatefulWidget {

  const DetailPage({
    super.key,
    required this.title,
    required this.prefix,
    required this.id,
    required this.buildContent,
    this.onEditPressed,
    this.onDeletePressed,
  });

  final String title;
  final String prefix;
  final int id;
  final Widget Function(DetailPageState) buildContent;
  final void Function(Map<String, dynamic>)? onEditPressed;
  final void Function(Map<String, dynamic>)? onDeletePressed;

  @override
  State<DetailPage> createState() => _DetailPageState();

}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailPageBloc>(context).add(DetailPageInitial(
      prefix: widget.prefix,
      id: widget.id,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<DetailPageBloc, DetailPageState>(
            listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
            listener: (context, state) {
              if (state.deleteStatus == LoadDataStatus.success) {
                // Navigator.pop(context);
                // 下面这个可以解决黑屏问题，原因未知。TODO
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                } else {
                  SystemNavigator.pop();
                }
              }
            }
          ),
          BlocListener<DetailPageBloc, DetailPageState>(
            listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
            listener: (context, state) {
              if (state.toggleStatus == LoadDataStatus.success) {
                BlocProvider.of<DetailPageBloc>(context).add(DetailPageReloaded());
              }
            },
          ),
          BlocListener<SimpleActionBloc, SimpleActionState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status == LoadDataStatus.success) {
                BlocProvider.of<DetailPageBloc>(context).add(DetailPageReloaded());
              }
            },
          ),
        ],
        child: BlocBuilder<DetailPageBloc, DetailPageState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(widget.title),
                actions: state.status == LoadDataStatus.success ? _buildActions(context, state.item) : [],
              ),
              body: Builder(
                builder: (BuildContext context) {
                  switch (state.status) {
                    case LoadDataStatus.progress:
                    case LoadDataStatus.initial:
                      return const LoadingPage();
                    case LoadDataStatus.success:
                      return widget.buildContent(state);
                    default:
                      return const ErrorPage();
                  }
                },
              ),
            );
          }
        )
    );
  }

  List<Widget> _buildActions(BuildContext context, Map<String, dynamic> item) {
    return [
      if (widget.onEditPressed != null) IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          widget.onEditPressed?.call(item);
        }
      ),
      if (widget.onDeletePressed != null) DialogConfirm(
        content: '确定删除此项目吗？',
        child: const Icon(Icons.delete),
        onConfirm: () {
          widget.onDeletePressed?.call(item);
        }
      )
    ];
  }

}
