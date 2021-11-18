import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';

class NumberButton extends StatelessWidget {
  const NumberButton({Key? key, required this.number}) : super(key: key);
  final int number;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return IconButton(
        onPressed: () {
          // Navigate to page directly on tap only if allowed
          (ref.read(navigatorServices).allowDirectNavigation)
              ? ref.read(navigatorServices).navigateToPage(number)
              : null;
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
            Text(
              number.toString(),
              style: TextStyle(
                color: constant.buttonTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
              ),
            ),
          ],
        ),
      );
    });
  }
}
