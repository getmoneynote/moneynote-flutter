import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {

  final Widget child;

  const BottomSheetContainer({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: child,
    );
  }

}