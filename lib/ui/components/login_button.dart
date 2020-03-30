import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color backgroundDisabledColor;
  final String text;
  final double buttonWidth;
  final Function onTap;

  LoginButton(
      {@required this.textColor,
        @required this.backgroundColor,
        this.backgroundDisabledColor,
        @required this.text,
        @required this.buttonWidth,
        @required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: backgroundDisabledColor,
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,)),
      onPressed: onTap,
      color: backgroundColor,
      textColor: textColor,
      minWidth: buttonWidth,
      height: 52,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    );
  }
}