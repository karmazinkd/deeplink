import 'package:flutter/material.dart';

class UiUtils{
  static const double MAX_BUTTON_WIDTH = 350.0;

  static double wideButtonWidth(BuildContext context){
    double screenW =  MediaQuery.of(context).size.width;
    double buttonWidth = screenW * 0.80;
    buttonWidth = buttonWidth > MAX_BUTTON_WIDTH ? MAX_BUTTON_WIDTH : buttonWidth;
    return buttonWidth;
  }
}