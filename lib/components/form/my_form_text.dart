import 'package:flutter/material.dart';
import '/commons/index.dart';
import '/components/index.dart';

class MyFormText extends StatefulWidget {

  final String label;
  final dynamic value;
  final Function(String value) onChange;
  final String? errorText;
  final bool required;
  final bool readOnly;

  const MyFormText({
    super.key,
    required this.label,
    this.value,
    required this.onChange,
    this.errorText,
    this.required = false,
    this.readOnly = false,
  });

  @override
  State<MyFormText> createState() => _MyFormTextState();
}

class _MyFormTextState extends State<MyFormText> {

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String value = '';
    if (widget.value.runtimeType == double) {
      value = removeDecimalZero(widget.value);
    } else if (widget.value.runtimeType == String) {
      value = widget.value;
    } else if (widget.value.runtimeType == Null) {
      value = '';
    } else {
      value = widget.value.toString();
    }
    controller.value = controller.value.copyWith(text: value);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.required) const Asterisk(),
          Text(widget.label, style: widget.readOnly ? buildReadOnlyLabelStyle(context) : buildLabelStyle(context)),
          const SizedBox(width: 15),
          Expanded(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  TextField(
                    controller: controller,
                    onChanged: (value) => widget.onChange(value),
                    enabled: !widget.readOnly,
                    style: widget.readOnly ? buildReadOnlyValueStyle(context) : buildValueStyle(context),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: inputDecoration,
                  ),
                  Positioned(
                    bottom: -17,
                    left: 0,
                    child: Text(widget.errorText ?? '', style: const TextStyle(fontSize: 12, color: Colors.red)),
                  )
                ],
              )
          )
        ]
    );
  }

}
