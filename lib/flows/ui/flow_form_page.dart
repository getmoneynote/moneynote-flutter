import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'widgets/flow_form/index.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/login/index.dart';
import '/flows/index.dart';

class FlowFormPage extends StatefulWidget {

  final int action; // 1-新增，2-修改，3-复制，4-退款
  final Map<String, dynamic> currentRow;

  const FlowFormPage({
    super.key,
    required this.action,
    this.currentRow = const { },
  });

  @override
  State<FlowFormPage> createState() => _FlowFormPageState();

}

class _FlowFormPageState extends State<FlowFormPage> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<FlowFormBloc>(context);
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    tabController.addListener(() {
      if(!tabController.indexIsChanging) {
        bloc.add(TabIndexChanged(tabController.index));
        bloc.add(DefaultLoaded(widget.action, widget.currentRow));
      }
    });
    if (widget.action == 1) {
      bloc.add(CurrentBookChanged(context.read<AuthBloc>().state.initState['book']));
      bloc.add(const TabIndexChanged(0));
    } else {
      bloc.add(CurrentBookChanged(widget.currentRow['book']));
      bloc.add(TabIndexChanged(widget.currentRow['typeIndex']));
    }
    bloc.add(DefaultLoaded(widget.action, widget.currentRow));
  }

  Widget _buildTitle(BuildContext context) {
    if (widget.action == 1) {
      return TabBar(
        controller: tabController,
        tabs: const [
          Tab(text: '支出'),
          Tab(text: '收入'),
          Tab(text: '转账'),
        ],
      );
    } else {
      return Text(translateAction(widget.action) + translateFlowType(widget.currentRow['type']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FlowFormBloc, FlowFormState>(
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
      child: BlocBuilder<FlowFormBloc, FlowFormState>(
        buildWhen: (previous, current) =>
        previous.valid != current.valid ||
            previous.submissionStatus != current.submissionStatus ||
            previous.tabIndex != current.tabIndex ||
            previous.form['confirm'] != current.form['confirm'],
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: _buildTitle(context),
              actions: [
                state.submissionStatus.isInProgress ? const LoadingIcon() :
                IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: state.valid ? () {
                    BlocProvider.of<FlowFormBloc>(context).add(Submitted());
                  } : null,
                )
              ],
            ),
            body: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  if (tabController.index > 0) {
                    tabController.animateTo(tabController.index - 1);
                  }
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  if (tabController.index < 2) {
                    tabController.animateTo(tabController.index + 1);
                  }
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                  child: Wrap(
                    runSpacing: 5,
                    children: [
                      BookInput(action: widget.action, currentRow: widget.currentRow),
                      const TitleInput(),
                      const CreateTimeInput(),
                      AccountInput(action: widget.action),
                      if (state.tabIndex != 2) CategoriesInput(action: widget.action),
                      if (state.tabIndex != 2) const CategoryAmountInput(),
                      if (state.tabIndex != 2) PayeeInput(action: widget.action),
                      if (state.tabIndex == 2) TransferToAccountInput(action: widget.action),
                      if (state.tabIndex == 2) const TransferAmountInput(),
                      TagsInput(action: widget.action),
                      ConfirmInput(action: widget.action),
                      const IncludeInput(),
                      if (state.form['confirm'] ?? true) const UpdateBalanceInput(),
                      const NotesInput(),
                    ],
                  ),
                ),
              ),
            )
          );
        }
      )
    );
  }

}
