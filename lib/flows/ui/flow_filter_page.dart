import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/login/index.dart';
import 'widgets/flow_filter/index.dart';

class FlowFilterPage extends StatelessWidget {

  const FlowFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFormPage(
      title: const Text('搜索账单'),
      actions: [
        IconButton(
          icon: const Icon(Icons.restart_alt),
          onPressed: () {
            context.read<ListPageBloc>().add(ListPageQueryReset({
              // 搜索的默认账本
              'book': context.read<AuthBloc>().state.initState['book']['id']
            }));
          },
        ),
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () {
            context.read<ListPageBloc>().add(ListPageReloaded());
            Navigator.pop(context);
          },
        )
      ],
      children: const [
        FilterBookInput(),
        FilterTitleInput(),
        FilterTypeInput(),
        FilterMinAmountInput(),
        FilterMaxAmountInput(),
        FilterMinTimeInput(),
        FilterMaxTimeInput(),
        FilterAccountInput(),
        FilterCategoryInput(),
        FilterTagInput(),
        FilterPayeeInput(),
        FilterConfirmInput(),
        FilterIncludeInput(),
        FilterNotesInput(),
      ]
    );
  }
}
