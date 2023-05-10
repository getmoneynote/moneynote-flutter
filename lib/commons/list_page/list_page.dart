import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/commons/index.dart';
import '/components/index.dart';

class ListPage extends StatefulWidget {

  const ListPage({
    super.key,
    required this.prefix,
    this.query,
    required this.buildContent,
  });

  final String prefix;
  final Map<String, dynamic>? query;
  final Widget Function(ListPageState) buildContent;


  @override
  State<ListPage> createState() => _ListPageState();

}

class _ListPageState extends State<ListPage> {

  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPageBloc>(context).add(ListPageInitial(
      prefix: widget.prefix,
      query: widget.query,
    ));
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ListPageBloc, ListPageState>(
          listenWhen: (previous, current) => previous.loadMoreStatus != current.loadMoreStatus,
          listener: (context, state) {
            if (state.loadMoreStatus == LoadDataStatus.success) {
              refreshController.loadComplete();
            } else if (state.loadMoreStatus == LoadDataStatus.failure) {
              refreshController.loadFailed();
            } else if (state.loadMoreStatus == LoadDataStatus.empty) {
              refreshController.loadNoData();
            }
          },
        ),
        BlocListener<ListPageBloc, ListPageState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status != LoadDataStatus.progress) {
              refreshController.refreshCompleted();
              refreshController.loadComplete();
            }
          },
        ),
        BlocListener<DetailPageBloc, DetailPageState>(
          listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == LoadDataStatus.success) {
              BlocProvider.of<ListPageBloc>(context).add(ListPageReloaded());
            }
          },
        ),
        BlocListener<DetailPageBloc, DetailPageState>(
          listenWhen: (previous, current) => previous.toggleStatus != current.toggleStatus,
          listener: (context, state) {
            if (state.toggleStatus == LoadDataStatus.success) {
              BlocProvider.of<ListPageBloc>(context).add(ListPageReloaded());
            }
          },
        ),
      ],
      child: BlocBuilder<ListPageBloc, ListPageState>(
        buildWhen: (previous, current) => previous.status != current.status || previous.items != current.items,
        builder: (context, state) {
          return _buildBody(context, state);
        }
      )
    );

  }

  Widget _buildBody(BuildContext context, ListPageState state) {
    LoadDataStatus status = state.status;
    switch (status) {
      case LoadDataStatus.progress:
      case LoadDataStatus.initial:
        return const LoadingPage();
      case LoadDataStatus.empty:
        return const Empty();
      case LoadDataStatus.success:
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: refreshController,
          child: widget.buildContent(state),
          onRefresh: () async {
            BlocProvider.of<ListPageBloc>(context).add(ListPageReloaded());
          },
          onLoading: () async {
            BlocProvider.of<ListPageBloc>(context).add(ListPageLoadMore());
          },
        );
      case LoadDataStatus.failure:
        return const ErrorPage();
    }
  }

}
