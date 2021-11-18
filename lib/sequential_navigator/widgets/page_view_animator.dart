import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';

class PageViewAnimator extends StatelessWidget {
  const PageViewAnimator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return PageView(
        children: ref.read(navigatorServices).pages,
        scrollDirection: Axis.vertical,
        controller: ref.read(navigatorServices).pageController,
      );
    });
  }
}
