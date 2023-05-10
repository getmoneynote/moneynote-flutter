import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {

  const ContentPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: child,
        )
    );
  }

}
