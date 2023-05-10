import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/charts/index.dart';

class FilterMaxTimeInput extends StatelessWidget {

  const FilterMaxTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChartIncomeCategoryBloc, ChartIncomeCategoryState, int?>(
        selector: (state) => state.query['maxTime'],
        builder: (context, state) {
          return MyFormDate(
            label: '起始时间',
            value: state,
            andTime: false,
            onChange: (value) => context.read<ChartIncomeCategoryBloc>().add(ChartIncomeCategoryQueryChanged({'maxTime': value})),
            allowClear: true,
            onClear: () {
              context.read<ChartIncomeCategoryBloc>().add(const ChartIncomeCategoryQueryChanged({'maxTime': null}));
            },
          );
        }
    );
  }

}


