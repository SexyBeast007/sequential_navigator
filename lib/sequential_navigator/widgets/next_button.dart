import 'package:flutter/material.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return IconButton(
        onPressed: () {
          ref.read(navigatorServices).nextPage();
        },
        icon: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Icon(
                Icons.circle,
                color: constant.buttonShadowColor,
                size: 32.0,
              ),
              left: 1.0,
              top: 1.0,
            ),
            Icon(
              Icons.circle,
              color: constant.buttonBackgroundColor,
              size: 32.0,
            ),
            Icon(
              Icons.arrow_downward_rounded,
              color: constant.buttonTextColor,
              size: 28.0,
            ),
          ],
        ),
      );
    });
  }
}
