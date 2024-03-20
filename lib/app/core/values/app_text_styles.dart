import 'package:flutter/material.dart';

abstract class AppTextStyle {

  static const loginTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  static const accountTab = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const newFlow = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const accountBalance = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const formLabelStyle = TextStyle(
    fontSize: 14,
  );

  static const formReadOnlyLabelStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey
  );

  static const formValueStyle = TextStyle(
    fontSize: 14,
  );

  static const formReadOnlyValueStyle = TextStyle(
      fontSize: 14,
      color: Colors.grey
  );

  static const optionStyle = TextStyle(color: Colors.white, fontSize: 18);

  static const InputDecoration inputDecoration = InputDecoration(
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

}
