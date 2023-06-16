import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/charts/index.dart';

class FilterMinTimeInput extends StatelessWidget {

  const FilterMinTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChartIncomeCategoryBloc, ChartIncomeCategoryState, int?>(
        selector: (state) => state.query['minTime'],
        builder: (context, state) {
          return MyFormDate(
            label: '起始时间',
            value: state,
            andTime: false,
            onChange: (value) => context.read<ChartIncomeCategoryBloc>().add(ChartIncomeCategoryQueryChanged({'minTime': value})),
            allowClear: true,
            onClear: () {
              context.read<ChartIncomeCategoryBloc>().add(const ChartIncomeCategoryQueryChanged({'minTime': null}));
            },
          );
        }
    );
  }

}


