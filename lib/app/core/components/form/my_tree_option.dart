import 'package:flutter/material.dart';
import '/app/core/components/flutter_tree-2.0.3/flutter_tree.dart';
import '../../base/enums.dart';
import '../pages/index.dart';


class MyTreeOption extends StatefulWidget {

  final String pageTitle;
  final List<dynamic> options;
  final LoadDataStatus status;
  final List<dynamic>? values;
  final Function onSelect;

  const MyTreeOption({
    super.key,
    required this.pageTitle,
    this.status = LoadDataStatus.initial,
    this.options = const [],
    this.values = const [],
    required this.onSelect,
  });

  @override
  State<MyTreeOption> createState() => _MyTreeOptionState();

}

class _MyTreeOptionState extends State<MyTreeOption> {

  late List<Map<String, dynamic>> newValues;

  @override
  void initState() {
    super.initState();
    newValues = [...(widget.values ?? [])];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.pageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              widget.onSelect.call(newValues);
            },
          ),
        ],
      ),
      body:  () {
        switch (widget.status) {
          case LoadDataStatus.progress:
          case LoadDataStatus.initial:
            return const LoadingPage();
          case LoadDataStatus.success:
            TreeNodeData mapServerDataToTreeData(Map data) {
              return TreeNodeData(
                extra: data,
                title: data['label'],
                expaned: false,
                checked: newValues.map((e) => e['value']).contains(data['value']),
                children: List.from(data['children']?.map((x) => mapServerDataToTreeData(x)) ?? []),
              );
            }

            List<TreeNodeData> treeData = List.generate(
              widget.options.length,
              (index) => mapServerDataToTreeData(widget.options[index]),
            );

            return TreeView(
              data: treeData,
              showFilter: false,
              showCheckBox: true,
              onCheck: (checked, data) {
                if (checked) {
                  setState(() {
                    newValues.add(data.extra);
                  });
                } else {
                  setState(() {
                    newValues.removeWhere((e) => e['value'] == data.extra['value']);
                  });
                }
              },
            );

          case LoadDataStatus.empty:
            return const EmptyPage();
          case LoadDataStatus.failure:
            return const ErrorPage();
        }
      }(),
    );
  }



}