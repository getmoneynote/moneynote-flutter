import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/login/index.dart';
import '/charts/index.dart';
import 'index.dart';


class ChartExpenseFilterPage extends StatelessWidget {

  const ChartExpenseFilterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyFormPage(
      title: const Text('搜索账单'),
      actions: [
        IconButton(
          icon: const Icon(Icons.restart_alt),
          onPressed: () {
            context.read<ChartExpenseCategoryBloc>().add(ChartExpenseCategoryQueryChanged({
              'bookId': context.read<AuthBloc>().state.initState['book']['id']
            }));
          },
        ),
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () {
            context.read<ChartExpenseCategoryBloc>().add(ChartExpenseCategoryReloaded());
            Navigator.pop(context);
          },
        )
      ],
      children: const [
        FilterBookInput(),
        FilterMinTimeInput(),
        FilterMaxTimeInput(),
        FilterTitleInput(),
        FilterPayeeInput(),
        FilterCategoryInput(),
        FilterTagInput(),
      ]
    );
  }
}
