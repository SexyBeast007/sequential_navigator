import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/navigator_subtitle.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/navigator_title.dart';

class NavigatorTitleBoxAnimation extends StatelessWidget {
  const NavigatorTitleBoxAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return AnimatedPositioned(
          top: ref.watch(navigatorServices).navigatorTitleBoxPosition(),
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 500),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              NavigatorTitle(),
              SizedBox(width: 3.0),
              NavigatorSubtitle(),
            ],
          ),
        );
      },
    );
  }
}