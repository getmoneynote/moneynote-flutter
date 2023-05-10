import 'package:flutter/material.dart';
import '/commons/index.dart';
import '/components/index.dart';
import 'my_tree_select_screen.dart';

class MyTreeSelect extends StatefulWidget {

  final String label;
  final dynamic value;
  final List<Map<String, dynamic>> options;
  final bool loading;
  final Function? onChange;
  final bool disabled;
  final bool required;
  final bool allowClear;
  final Function? onClear;
  final bool multiple;

  const MyTreeSelect({
    super.key,
    required this.label,
    this.value,
    required this.options,
    this.loading = false,
    this.onChange,
    this.disabled = false,
    this.required = false,
    this.allowClear = false,
    this.onClear,
    this.multiple = false,
  });

  @override
  State<MyTreeSelect> createState() => _MyTreeSelectState();

}

class _MyTreeSelectState extends State<MyTreeSelect> {

  @override
  Widget build(BuildContext context) {
    String labelText = '一个或多个';
    if (widget.value != null && widget.value.isNotEmpty) {
      labelText = widget.value.map((e) => e['label']).join(", ");
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.required) const Asterisk(),
        Expanded(
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(widget.label, style: buildLabelStyle(context)),
            trailing: Wrap(
              children: [
                Text(widget.loading ? 'loading' : labelText),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
            onTap: () {
              _navigateAndDisplaySelection(context);
            }
          ),
        ),
        if (widget.allowClear && !isNullEmpty(widget.value))
          IconButton(
            onPressed: () {
              widget.onClear?.call();
            },
            icon:const Icon(Icons.backspace)
          )
      ],
    );
  }

  // https://docs.flutter.dev/cookbook/navigation/returning-data
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final newValue = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyTreeSelectSelectionScreen(
        title: '选择${widget.label}',
        options: widget.options,
        value: widget.value,
      )),
    );
    if (!mounted) return;
    widget.onChange?.call(newValue);
  }

}

