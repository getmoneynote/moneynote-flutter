import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/index.dart';
import '/commons/index.dart';

class ListFilterText extends StatelessWidget {

  const ListFilterText({
    super.key,
    required this.name,
    required this.label,
  });

  final String name;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ListPageBloc, ListPageState, String?>(
      selector: (state) => state.query[name],
      builder: (context, state) {
        return MyFormText(
          label: label,
          value: state,
          onChange: (value) => context.read<ListPageBloc>().add(ListPageQueryChanged({name: value})),
        );
      }
    );
  }

}
