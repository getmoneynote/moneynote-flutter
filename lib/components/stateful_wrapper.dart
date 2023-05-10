/// Wrapper for stateful functionality to provide onInit calls in stateles widget
/// https://stackoverflow.com/questions/71211611/how-should-i-implement-the-init-method-in-a-stateful-or-stateless-widget
/// @deprecated 已弃用
import 'package:flutter/widgets.dart';

class StatefulWrapper extends StatefulWidget {

  final Function onInit;
  final Widget child;

  const StatefulWrapper({
    super.key,
    required this.onInit,
    required this.child
  });

  @override
  State<StatefulWrapper> createState() => _StatefulWrapperState();

}
class _StatefulWrapperState extends State<StatefulWrapper> {

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

}