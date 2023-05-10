import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';


class OrderButton extends StatelessWidget {

  const OrderButton({
    super.key,
    required this.items,
  });

  final Map<String, String> items;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ListPageBloc, ListPageState, String>(
      selector: (state) => state.query[sortParameter],
      builder: (context, state) {
        return PopupMenu(
          onSelected: (selected) {
            if (selected != state) {
              BlocProvider.of<ListPageBloc>(context).add(ListPageSortQueryChanged({
                sortParameter: selected
              }));
            }
          },
          items: items,
          selected: state,
        );
      }
    );
  }

}