import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/charts/index.dart';

class FilterBookInput extends StatefulWidget {

  const FilterBookInput({super.key});

  @override
  State<FilterBookInput> createState() => _FilterBookInputState();

}

class _FilterBookInputState extends State<FilterBookInput> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(const SelectOptionsInitial(
      prefix: 'books',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SelectOptionsBloc, SelectOptionsState, SelectOptionsModel>(
        selector: (state) => state.map['books'] ?? const SelectOptionsModel(),
        builder: (context, state) {
          return BlocSelector<ChartIncomeCategoryBloc, ChartIncomeCategoryState, dynamic>(
            selector: (state) => state.query['bookId'],
            builder: (context, state1) {
              return MySelect(
                multiple: false,
                label: '所属账本',
                options: state.options,
                value: state1,
                onChange: (value) {
                  context.read<ChartIncomeCategoryBloc>().add(ChartIncomeCategoryQueryChanged({'bookId': value}));
                },
                loading: state.status != LoadDataStatus.success,
                allowClear: false,
              );
            }
          );
        }
    );
  }
}


