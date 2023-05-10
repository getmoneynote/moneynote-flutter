import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/index.dart';
import '/commons/index.dart';
import '/flows/index.dart';


class BookInput extends StatefulWidget {

  final int action;
  final Map<String, dynamic> currentRow;

  const BookInput({
    super.key,
    required this.action,
    required this.currentRow,
  });

  @override
  State<BookInput> createState() => _BookInputState();
}

class _BookInputState extends State<BookInput> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectOptionsBloc>(context).add(SelectOptionsInitial(
      prefix: 'books',
      query: {
        'keep': widget.action != 1 ? widget.currentRow['book']['id'] : null
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final optionModel = context.watch<SelectOptionsBloc>().state.map['books'] ?? const SelectOptionsModel();
    return BlocBuilder<FlowFormBloc, FlowFormState>(
      buildWhen: (previous, current) => previous.currentBook != current.currentBook,
      builder: (context, state) {
        // var options = [ ...optionModel.options ];
        // if (widget.action != 1) {
        //   if (state.currentBook['id'] != null && !options.map((e) => e['id']).contains(state.currentBook['id'])) {
        //     options.insert(0, state.currentBook);
        //   }
        // }
        return MySelect(
          label: '所属账本',
          required: true,
          options: optionModel.options,
          value: state.form['bookId'],
          onChange: (value) {
            context.read<FlowFormBloc>().add(CurrentBookChanged( optionModel.options.firstWhere((e) => e['id'] == value) ));
          },
          loading: optionModel.status != LoadDataStatus.success,
          disabled: widget.action != 1,
        );
      }
    );
  }

}



