import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';

class ListFilterSelect extends StatefulWidget {

  const ListFilterSelect({
    super.key,
    this.prefix,
    this.query,
    required this.name,
    required this.label,
    this.options,
    this.multiple = false,
  });

  final String? prefix;
  final Map<String, dynamic>? query;
  final String name;
  final String label;
  final List<Map<String, dynamic>>? options;
  final bool multiple;

  @override
  State<ListFilterSelect> createState() => _ListFilterSelectState();

}

class _ListFilterSelectState extends State<ListFilterSelect> {

  late bool isPrefix;

  @override
  void initState() {
    super.initState();
    isPrefix = widget.prefix?.isNotEmpty ?? false;
    if (isPrefix) {
      BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
        prefix: widget.prefix!,
        query: widget.query,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SelectOptionsBloc, SelectOptionsState, SelectOptionsModel>(
      selector: (state) => state.map[widget.prefix] ?? const SelectOptionsModel(),
      builder: (context, state) {
        return BlocSelector<ListPageBloc, ListPageState, dynamic>(
          selector: (state) => state.query[widget.name],
          builder: (context, state1) {
            return MySelect(
              multiple: widget.multiple,
              label: widget.label,
              options: isPrefix ? (state.options) : (widget.options ?? []),
              value: state1,
              onChange: (value) {
                context.read<ListPageBloc>().add(ListPageQueryChanged({widget.name: value}));
              },
              loading: isPrefix ? state.status != LoadDataStatus.success : false,
              allowClear: true,
              onClear: () {
                context.read<ListPageBloc>().add(ListPageQueryChanged({widget.name: widget.multiple ? [] : ''}));
              },
            );
          }
        );
      }
    );
  }

}
