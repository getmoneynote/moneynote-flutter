import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/index.dart';
import '/commons/index.dart';

class ListFilterDate extends StatelessWidget {

  const ListFilterDate({
    super.key,
    required this.name,
    required this.label,
  });

  final String name;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ListPageBloc, ListPageState, int?>(
      selector: (state) => state.query[name],
      builder: (context, state) {
        return MyFormDate(
          label: label,
          value: state,
          andTime: false,
          onChange: (value) => context.read<ListPageBloc>().add(ListPageQueryChanged({name: value})),
          allowClear: true,
          onClear: () {
            context.read<ListPageBloc>().add(ListPageQueryChanged({name: null}));
          },
        );
      }
    );
  }

}
