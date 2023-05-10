// 已弃用
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends StatelessWidget {

  final int? value;
  final Function(DateTime) onDateChange;
  final Function(TimeOfDay) onTimeChange;

  const DateTimeInput({
    super.key,
    this.value,
    required this.onDateChange,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    int initValue = value ?? DateTime.now().millisecondsSinceEpoch;
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.fromMillisecondsSinceEpoch(initValue),
              firstDate: DateTime(2000),
              lastDate: DateTime(2300)
            ).then((picked) => {
              if (picked != null) onDateChange(picked)
            });
          },
          child: const Text('选择日期')
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(initValue))
            ).then((picked) => {
              if (picked != null) onTimeChange(picked)
            });
          },
          child: const Text('选择时间')
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(DateFormat('yyyy-MM-dd kk:mm').format(DateTime.fromMillisecondsSinceEpoch(initValue))),
        )
      ],
    );
  }

}