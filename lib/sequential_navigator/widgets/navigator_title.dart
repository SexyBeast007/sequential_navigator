import 'package:flutter/material.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;

class NavigatorTitle extends StatelessWidget {
  const NavigatorTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Text(
        constant.majorSectionText,
        style: TextStyle(
          color: constant.majorSectionTextColor,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
