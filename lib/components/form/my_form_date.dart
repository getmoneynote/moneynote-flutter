import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/commons/index.dart';
import '/components/index.dart';

class MyFormDate extends StatefulWidget {

  final String label;
  final int? value;
  final Function(int value) onChange;
  final bool required;
  final bool andTime;
  final bool allowClear;
  final Function? onClear;

  const MyFormDate({
    super.key,
    required this.label,
    this.value,
    required this.onChange,
    this.required = false,
    this.andTime = true,
    this.allowClear = false,
    this.onClear,
  });

  @override
  State<MyFormDate> createState() => _MyFormDateState();

}

class _MyFormDateState extends State<MyFormDate> {

  late TextEditingController controller;
  late int initValue;

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

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    controller.value = controller.value.copyWith(text: widget.andTime ? dateTimeFormat(widget.value) : dateFormat(widget.value));
    initValue = widget.value ?? DateTime.now().millisecondsSinceEpoch;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.required) const Asterisk(),
        Text(widget.label, style: buildLabelStyle(context)),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyLarge,
            readOnly: true,
            decoration: inputDecoration,
            onTap: () => _showDialog(CupertinoDatePicker(
              initialDateTime: DateTime.fromMillisecondsSinceEpoch(initValue),
              mode: widget.andTime ? CupertinoDatePickerMode.dateAndTime : CupertinoDatePickerMode.date,
              use24hFormat: true,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) => widget.onChange(newDate.millisecondsSinceEpoch),
            ), context),
          )
        ),
        if (widget.allowClear && widget.value != null)
          IconButton(
            onPressed: () {
              widget.onClear?.call();
            },
            icon:const Icon(Icons.backspace)
          )
      ]
    );
  }
}
