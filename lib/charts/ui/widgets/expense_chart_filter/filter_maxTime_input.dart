import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/charts/index.dart';

class FilterMaxTimeInput extends StatelessWidget {

  const FilterMaxTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChartExpenseCategoryBloc, ChartExpenseCategoryState, int?>(
        selector: (state) => state.query['maxTime'],
        builder: (context, state) {
          return MyFormDate(
            label: '起始时间',
            value: state,
            andTime: false,
            onChange: (value) => context.read<ChartExpenseCategoryBloc>().add(ChartExpenseCategoryQueryChanged({'maxTime': value})),
            allowClear: true,
            onClear: () {
              context.read<ChartExpenseCategoryBloc>().add(const ChartExpenseCategoryQueryChanged({'maxTime': null}));
            },
          );
        }
    );
  }

}


