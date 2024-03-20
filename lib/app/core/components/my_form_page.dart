import 'package:flutter/material.dart';

class MyFormPage extends StatelessWidget {

  final Widget title;
  final List<Widget> children;
  final List<Widget> actions;

  const MyFormPage({
    super.key,
    required this.title,
    required this.children,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: title,
        actions: actions,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
          child: Wrap(
            runSpacing: 5,
            children: children,
          ),
        ),
      ),
    );
  }

}