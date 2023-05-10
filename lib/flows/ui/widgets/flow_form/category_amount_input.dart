import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/flows/index.dart';

class CategoryAmountInput extends StatelessWidget {

  const CategoryAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowFormBloc, FlowFormState>(
      buildWhen: (previous, current) => previous.categoryAmount != current.categoryAmount || previous.needConvert != current.needConvert,
      builder: (context, state) {
        return Column(
          children: state.categoryAmount.map<Widget>((e) {
            return Column(
              children: [
                MyFormText(
                  required: true,
                  label: "${e['categoryName']}金额",
                  value: e['amount'],
                  onChange: (value) {
                    context.read<FlowFormBloc>().add(CategoryAmountChanged(e['categoryId'], value));
                  },
                ),
                if (state.needConvert) MyFormText(
                  required: true,
                  label: "${e['categoryName']}折合${state.convertCode}",
                  value: e['convertedAmount'],
                  onChange: (value) {
                    context.read<FlowFormBloc>().add(CategoryConvertedAmountChanged(e['categoryId'], value));
                  },
                ),
              ],
            );
          }).toList(),
        );
      }
    );
  }

}
