import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/flows/index.dart';

class TagsInput extends StatelessWidget {

  const TagsInput({
    super.key,
    required this.action,
  });

  final int action;

  Map<String, dynamic> _buildQuery(FlowFormState state) {
    Map<String, dynamic> query = {
      'bookId': state.currentBook['id'],
      if (action != 1) 'keeps': List<int>.from(state.currentRow['tags']?.map((e) => e['tag']['id']) ?? [ ])
    };
    if (state.tabIndex == 0) {
      query = { ...query, 'canExpense': true };
    }
    if (state.tabIndex == 1) {
      query = { ...query, 'canIncome': true };
    }
    if (state.tabIndex == 2) {
      query = { ...query, 'canTransfer': true };
    }
    return query;
  }


  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['tags'] ?? const SelectOptionsModel();
    return BlocConsumer<FlowFormBloc, FlowFormState>(
      listenWhen: (previous, current) => previous.currentBook != current.currentBook ||
                                         previous.tabIndex != current.tabIndex ||
                                         previous.currentRow['tags'] != current.currentRow['tags'],
      listener: (context, state) {
        BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
          prefix: 'tags',
          query: _buildQuery(state)
        ));
      },
      buildWhen: (previous, current) => previous.form['tags'] != current.form['tags'] || previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        return MyTreeSelect(
          multiple: true,
          label: '标签',
          required: false,
          options: optionModel.options,
          value: state.form['tags'],
          onChange: (value) {
            context.read<FlowFormBloc>().add(FieldChanged({ 'tags': value }));
            // setState(() {  }); //可以强制刷新
          },
          loading: optionModel.status != LoadDataStatus.success,
        );
      },
    );
  }

}

