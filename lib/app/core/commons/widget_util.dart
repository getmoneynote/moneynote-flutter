import 'package:flutter/cupertino.dart';

void fullDialog(BuildContext context, Widget widget) {
  Navigator.of(context, rootNavigator: false).push( // ensures fullscreen
      CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => widget
      )
  );
}