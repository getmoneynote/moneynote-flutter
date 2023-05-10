import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {

  const ToggleButton({
    super.key,
    required this.enable,
    required this.onPressed
  });

  final bool enable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(enable ? '禁用' : '启用')
      ),
    );
  }

}
