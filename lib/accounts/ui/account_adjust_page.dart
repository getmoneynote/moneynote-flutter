import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/accounts/index.dart';
import 'widgets/index.dart';


class AccountAdjustPage extends StatefulWidget {

  const AccountAdjustPage({
    super.key,
    required this.action,
    required this.currentRow,
  });

  final int action;
  final Map<String, dynamic> currentRow;

  @override
  State<AccountAdjustPage> createState() => _AccountAdjustPageState();

}


class _AccountAdjustPageState extends State<AccountAdjustPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountAdjustBloc>(context).add(AdjustDefaultLoaded(widget.action, widget.currentRow));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountAdjustBloc, AccountAdjustState>(
      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          Navigator.of(context).pop();
          BlocProvider.of<ListPageBloc>(context).add(ListPageReloaded());
          BlocProvider.of<DetailPageBloc>(context).add(DetailPageReloaded());
        }
      },
      child: MyFormPage(
        title: const Text('调整账户余额'),
        actions: [
          BlocBuilder<AccountAdjustBloc, AccountAdjustState>(
            buildWhen: (previous, current) => previous.valid != current.valid || previous.submissionStatus != current.submissionStatus,
            builder: (context, state) {
              return state.submissionStatus.isInProgress ? const LoadingIcon():
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: state.valid ? () {
                  BlocProvider.of<AccountAdjustBloc>(context).add(AdjustSubmitted());
                } : null,
              );
            },
          ),
        ],
        children: [
          AdjustBookInput(action: widget.action, currentRow: widget.currentRow),
          const AdjustTitleInput(),
          const AdjustCreateTimeInput(),
          if (widget.action == 1) const AdjustBalanceInput(),
          const AdjustNotesInput(),
        ]
      ),
    );
  }
}
