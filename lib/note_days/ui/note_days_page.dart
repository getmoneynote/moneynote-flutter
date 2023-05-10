import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/note_days/index.dart';

class NoteDaysPage extends StatelessWidget {

  const NoteDaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("提醒事项"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<ListPageBloc>(context).add(ListPageReloaded());
              },
              icon: const Icon(Icons.refresh)
          ),
          // IconButton(
          //     onPressed: () {
          //       fullDialog(context, const FlowFilterPage());
          //     },
          //     icon: const Icon(Icons.search)
          // )
        ],
      ),
      body: ListPage(
        prefix: 'note-days',
        buildContent: (ListPageState state) {
          return _buildBody(context, state);
        },
      )
    );
  }

  Widget _buildBody(BuildContext context, ListPageState state) {
    if (state.prefix != 'note-days') {
      return const LoadingPage();
    }
    List<Map<String, dynamic>> items = state.items;
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = items.elementAt(index);
        return ListTile(
          dense: true,
          title: Text(item['title']),
          subtitle: item['notes'] != null && item['notes']!.isNotEmpty ? Text(item['notes']) : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${dateFormat(item['nextDate'])}，还有${item['countDown']}天'),
              // const Icon(Icons.keyboard_arrow_right)
            ],
          ),
          onTap: () {
            // navigateTo(context, BookDetailPage(id: item['id']));
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

}