import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/charts/index.dart';

class FilterMinTimeInput extends StatelessWidget {

  const FilterMinTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChartExpenseCategoryBloc, ChartExpenseCategoryState, int?>(
        selector: (state) => state.query['minTime'],
        builder: (context, state) {
          return MyFormDate(
            label: '终止时间',
            value: state,
            andTime: false,
            onChange: (value) => context.read<ChartExpenseCategoryBloc>().add(ChartExpenseCategoryQueryChanged({'minTime': value})),
            allowClear: true,
            onClear: () {
              context.read<ChartExpenseCategoryBloc>().add(const ChartExpenseCategoryQueryChanged({'minTime': null}));
            },
          );
        }
    );
  }

}


