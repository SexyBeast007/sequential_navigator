import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';

class NavigatorSubtitle extends StatelessWidget {
  const NavigatorSubtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return RotatedBox(
          quarterTurns: -1,
          child: Text(
            ref.watch(navigatorServices).navigatorSubtitleText(),
            style: TextStyle(
              color: constant.minorSectionTextColor,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
