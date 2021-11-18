import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;

class Line extends StatelessWidget {
  const Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Container(
        color: constant.lineColor,
        width: 3.0,
        height: ref.read(navigatorServices).lineHeight(),
      );
    });
  }
}
