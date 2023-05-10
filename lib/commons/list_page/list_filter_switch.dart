import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/components/index.dart';
import '/commons/index.dart';

class ListFilterSwitch extends StatelessWidget {

  const ListFilterSwitch({
    super.key,
    required this.name,
    required this.label,
  });

  final String name;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ListPageBloc, ListPageState, bool?>(
      selector: (state) => state.query[name],
      builder: (context, state) {
        return MyFormSwitch(
          label: label,
          value: state,
          onChange: (value) => context.read<ListPageBloc>().add(ListPageQueryChanged({name: value})),
        );
      }
    );
  }

}
