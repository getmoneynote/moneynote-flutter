import 'package:flutter/material.dart';
import '../flutter_tree-2.0.3/flutter_tree.dart';

class MyTreeSelectSelectionScreen extends StatefulWidget {

  const MyTreeSelectSelectionScreen({
    super.key,
    required this.title,
    required this.options,
    this.value,
  });

  final String title;
  final List<Map<String, dynamic>> options;
  final List<Map<String, dynamic>>? value;

  @override
  State<MyTreeSelectSelectionScreen> createState() => _MyTreeSelectSelectionScreenState();
}

class _MyTreeSelectSelectionScreenState extends State<MyTreeSelectSelectionScreen> {

  late List<Map<String, dynamic>> newValue;

  @override
  void initState() {
    super.initState();
    newValue = [...(widget.value ?? [])];
  }

  @override
  Widget build(BuildContext context) {

    TreeNodeData mapServerDataToTreeData(Map data) {
      return TreeNodeData(
        extra: data,
        title: data['name'],
        expaned: false,
        checked: newValue.map((e) => e['id']).contains(data['id']),
        children: List.from(data['children']?.map((x) => mapServerDataToTreeData(x)) ?? []),
      );
    }

    List<TreeNodeData> treeData = List.generate(
      widget.options.length,
      (index) => mapServerDataToTreeData(widget.options[index]),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, newValue);
          return false;
        },
        child: TreeView(
          data: treeData,
          showFilter: false,
          showCheckBox: true,
          onCheck: (checked, data) {
            if (checked) {
              setState(() {
                newValue.add(data.extra);
              });
            } else {
              setState(() {
                newValue.removeWhere((e) => e['id'] == data.extra['id']);
              });
            }
          },
        ),
      ),
    );
  }

}