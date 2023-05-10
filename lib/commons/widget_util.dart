import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Message {

  static success(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static error(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}

void fullDialog(BuildContext context, Widget widget) {
  Navigator.of(context, rootNavigator: false).push( // ensures fullscreen
      CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => widget
      )
  );
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

const InputDecoration inputDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.black)
  ),
  disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.grey)
  ),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.blue)
  ),
);

TextStyle buildLabelStyle(BuildContext context) {
  TextStyle style = Theme.of(context).textTheme.bodyLarge ?? const TextStyle();
  style = style.apply(fontSizeFactor: 1.1);
  return style;
}

TextStyle buildReadOnlyLabelStyle(BuildContext context) {
  TextStyle style = buildLabelStyle(context);
  style = style.apply(color: Colors.grey);
  return style;
}

TextStyle buildValueStyle(BuildContext context) {
  TextStyle style = Theme.of(context).textTheme.bodyLarge ?? const TextStyle();
  return style;
}

TextStyle buildReadOnlyValueStyle(BuildContext context) {
  TextStyle style = Theme.of(context).textTheme.bodyLarge ?? const TextStyle();
  style = style.apply(color: Colors.grey);
  return style;
}

List<DoughnutSeries<Map<String, dynamic>, String>> getDefaultDoughnutSeries(xys) {
  return [
    DoughnutSeries<Map<String, dynamic>, String>(
      radius: '80%',
      innerRadius: '70%',
      dataSource: xys,
      xValueMapper: (data, _) => data['x'],
      yValueMapper: (data, _) => data['y'],
      dataLabelMapper: (data, _) => "${data['x']} : ${data['percent']}%",
      dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(fontSize: 6),
          labelPosition: ChartDataLabelPosition.outside
      ),
      legendIconType: LegendIconType.circle,
    )
  ];
}

num calChartTotal(List<Map<String, dynamic>> data) {
  num total = data.fold(0, (previousValue, element) => previousValue + element['y']*100);
  // 解决精度问题
  return total / 100;
}