import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/accounts/index.dart';
import 'widgets/index.dart';

class AccountFormPage extends StatefulWidget {

  final int action; // 1-新增，2-修改
  final String type;
  final Map<String, dynamic> currentRow;

  const AccountFormPage({
    super.key,
    required this.action,
    required this.type,
    this.currentRow = const { },
  });

  @override
  State<AccountFormPage> createState() => _AccountFormPageState();

}

class _AccountFormPageState extends State<AccountFormPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountFormBloc>(context).add(DefaultLoaded(widget.action, widget.type, widget.currentRow));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountFormBloc, AccountFormState>(
      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          Navigator.of(context).pop();
          BlocProvider.of<ListPageBloc>(context).add(ListPageReloaded());
          if (widget.action == 2) {
            BlocProvider.of<DetailPageBloc>(context).add(DetailPageReloaded());
          }
        }
      },
      child: MyFormPage(
        title: Text(translateAction(widget.action) + accountTypeToName(widget.type)),
        actions: [
          BlocBuilder<AccountFormBloc, AccountFormState>(
            buildWhen: (previous, current) => previous.valid != current.valid || previous.submissionStatus != current.submissionStatus,
            builder: (context, state) {
              return state.submissionStatus.isInProgress ? const LoadingIcon():
                IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: state.valid ? () {
                    BlocProvider.of<AccountFormBloc>(context).add(Submitted());
                  } : null,
                );
            },
          ),
        ],
        children: [
          CurrencyInput(action: widget.action),
          const NameInput(),
          BalanceInput(action: widget.action),
          if (widget.type == 'CREDIT' || widget.type == 'DEBT') const CreditLimitInput(),
          if (widget.type == 'CREDIT' || widget.type == 'DEBT') BillDayInput(type: widget.type),
          if (widget.type == 'DEBT') const AprInput(),
          const NoInput(),
          const CanExpenseInput(),
          const CanIncomeInput(),
          const CanTransferFromInput(),
          const CanTransferToInput(),
          const IncludeInput(),
          const NotesInput(),
        ],
      ),
    );
  }

}
