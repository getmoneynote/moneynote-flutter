import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/login/index.dart';
import '/accounts/index.dart';


class AdjustBookInput extends StatefulWidget {

  final int action;
  final Map<String, dynamic> currentRow;

  const AdjustBookInput({
    super.key,
    required this.action,
    required this.currentRow,
  });

  @override
  State<AdjustBookInput> createState() => _AdjustBookInputState();
}

class _AdjustBookInputState extends State<AdjustBookInput> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
      prefix: 'books',
      query: {
        'keep': widget.action != 1 ? widget.currentRow['book']['id'] : null
      },
    ));
    if (widget.action == 1) {

      context.read<AccountAdjustBloc>().add(AdjustFieldChanged( {'bookId': context.read<AuthBloc>().state.initState['book']?['id']} ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['books'] ?? const SelectOptionsModel();
    return BlocBuilder<AccountAdjustBloc, AccountAdjustState>(
      buildWhen: (previous, current) => previous.form['bookId'] != current.form['bookId'],
      builder: (context, state) {
        return MySelect(
          label: '所属账本',
          required: true,
          options: optionModel.options,
          value: state.form['bookId'],
          onChange: (value) {
            context.read<AccountAdjustBloc>().add(AdjustFieldChanged( {'bookId': value} ));
          },
          loading: optionModel.status != LoadDataStatus.success,
        );
      }
    );
  }

}



