import 'package:flutter/material.dart';
import '/app/core/values/app_text_styles.dart';
import '../pages/index.dart';
import '/app/core/base/enums.dart';

class MyOption extends StatefulWidget {

  final List<dynamic> options;
  final LoadDataStatus status;
  final dynamic value;
  final Function onSelect;
  final String pageTitle;

  const MyOption({
    super.key,
    this.status = LoadDataStatus.initial,
    this.options = const [],
    this.value = const { },
    required this.onSelect,
    required this.pageTitle
  });

  @override
  State<MyOption> createState() => _MyOptionState();

}

class _MyOptionState extends State<MyOption> {

  bool isSearch = false;
  String key = '';
  List<dynamic> optionsFilter = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    optionsFilter = widget.options;
    if (key.isNotEmpty) {
      optionsFilter = widget.options.where((e) => e['label'].toLowerCase().contains(key.toLowerCase())).toList();
    }
    return Scaffold(
      appBar: isSearch ? appBar2() : appBar1(),
      body: () {
        switch (widget.status) {
          case LoadDataStatus.progress:
          case LoadDataStatus.initial:
            return const LoadingPage();
          case LoadDataStatus.success:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 10,
                  children: optionsFilter.map((e) => ChoiceChip(
                    label: Text(
                      e['label'],
                    ),
                    selected: widget.value?['value'] == e['value'],
                    onSelected: (bool selected) {
                      widget.onSelect.call(e);
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    labelStyle: TextStyle(
                      color: widget.value?['value'] == e['value'] ? Colors.white : Colors.black,
                    ),
                  )).toList(),
                ),
              ),
            );
          case LoadDataStatus.empty:
            return const EmptyPage();
          case LoadDataStatus.failure:
            return const ErrorPage();
        }
      }()
    );
  }

  AppBar appBar1() {
    return AppBar(
      centerTitle: true,
      title: Text(widget.pageTitle),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() => isSearch = true);
          },
        ),
      ],
    );
  }

  AppBar appBar2() {
    return AppBar(
      leading: const Icon(Icons.search),
      title: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search on Options',
          hintStyle: AppTextStyle.optionStyle,
        ),
        autofocus: true,
        cursorColor: Colors.white,
        style: AppTextStyle.optionStyle,
        onChanged: (text) {
          setState(() {
            key = text;
          });
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() => isSearch = false);
          },
        ),
      ],
    );
  }

}