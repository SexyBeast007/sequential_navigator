import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';
import 'number_button.dart';

class NumberButtonAnimation extends StatelessWidget {
  const NumberButtonAnimation({Key? key, required this.buttonNumber}) : super(key: key);
  final int buttonNumber;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return AnimatedPositioned(
          top: ref.watch(navigatorServices.select((service) => service.buttonPosition(buttonNumber))),
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 500),
          child: NumberButton(number: buttonNumber),
        );
      },
    );
  }
}
