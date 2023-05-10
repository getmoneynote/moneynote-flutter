import 'package:flutter/material.dart';

class DialogConfirm extends StatelessWidget {

  final String? title;
  final String? content;
  final String? okText;
  final String? cancelText;
  final Widget child;
  final Function() onConfirm;
  final bool enable;

  const DialogConfirm({
    super.key,
    this.title,
    this.content,
    this.okText,
    this.cancelText,
    required this.child,
    required this.onConfirm,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? () async {
        final bool? isConfirm = await showDialog<bool>(
          context: context,
          builder: (_) => WillPopScope(
            child: AlertDialog(
              title: title != null ? Text(title!) : null,
              content: Text( content ?? '确认此操作吗？' ),
              actions: <Widget>[
                TextButton(
                  child: Text( cancelText ?? '取消'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                TextButton(
                  child: Text( okText ?? '确认'),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ),
            onWillPop: () async {
              Navigator.pop(context, false);
              return true;
            },
          ),
        );
        if (isConfirm ?? false) {
          onConfirm();
        }
      } : null,
      child: child,
    );
  }
}
