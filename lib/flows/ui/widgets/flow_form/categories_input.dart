import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/flows/index.dart';

class CategoriesInput extends StatelessWidget {

  final int action;

  const CategoriesInput({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['categories'] ?? const SelectOptionsModel();
    return BlocConsumer<FlowFormBloc, FlowFormState>(
      listenWhen: (previous, current) => previous.currentBook != current.currentBook ||
                                         previous.tabIndex != current.tabIndex ||
                                         previous.currentRow['categories'] != current.currentRow['categories'],
      listener: (context, state) {
        if (state.tabIndex != 2) {
          BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
            prefix: 'categories',
            query: {
              'bookId': state.currentBook['id'],
              'type': flowTabIndexToType(state.tabIndex),
              'keeps': List<int>.from(state.currentRow['categories']?.map((e) => e['category']['id']) ?? [ ])
            }
          ));
        }
      },
      buildWhen: (previous, current) => previous.form['categories'] != current.form['categories'] || previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        return MyTreeSelect(
          multiple: true,
          label: '分类',
          required: true,
          options: optionModel.options,
          value: state.form['categories'],
          onChange: (value) {
            context.read<FlowFormBloc>().add(CategoryChanged(value));
          },
          loading: optionModel.status != LoadDataStatus.success,
        );
      },
    );
  }

}



