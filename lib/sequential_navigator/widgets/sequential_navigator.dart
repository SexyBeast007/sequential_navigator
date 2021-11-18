import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/line.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/navigator_title_animation.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/number_button_animation.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/page_view_animator.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;

class SequentialNavigator extends StatelessWidget {
  final List<SliverChildBuilderDelegate> pages;
  // Color properties
  final Color? backgroundColor;
  final Color? headerBackgroundColor;
  final Color? headerTextColor;
  final Color? footerBackgroundColor;
  final Color? footerIconColor;
  final Color? footerTextColor;
  final Color? majorSectionTextColor;
  final Color? minorSectionTextColor;
  final Color? buttonBackgroundColor;
  final Color? buttonShadowColor;
  final Color? buttonTextColor;
  final Color? lineColor;
  // Text properties
  final String? majorSectionText;
  final String? pageOneSubtitle;
  final String? pageTwoSubtitle;
  final String? pageThreeSubtitle;
  final String? pageFourSubtitle;
  final String? pageFiveSubtitle;
  final String? pageSixSubtitle;
  final String? pageSevenSubtitle;
  // Settings
  final bool? allowDirectNavigation;
  const SequentialNavigator({
    Key? key,
    required this.pages,
    this.footerTextColor,
    this.majorSectionTextColor,
    this.minorSectionTextColor,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.headerTextColor,
    this.footerBackgroundColor,
    this.footerIconColor,
    this.majorSectionText,
    this.buttonBackgroundColor,
    this.buttonShadowColor,
    this.buttonTextColor,
    this.lineColor,
    this.pageOneSubtitle,
    this.pageTwoSubtitle,
    this.pageThreeSubtitle,
    this.pageFourSubtitle,
    this.pageFiveSubtitle,
    this.pageSixSubtitle,
    this.pageSevenSubtitle,
    this.allowDirectNavigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color assignments
    constant.backgroundColor = backgroundColor ?? constant.darkGreen;
    constant.headerBackgroundColor = headerBackgroundColor ?? constant.darkGreen;
    constant.headerIconColor = headerBackgroundColor ?? constant.lightGreen;
    constant.headerTextColor = headerTextColor ?? constant.lightGreen;
    constant.footerBackgroundColor = footerBackgroundColor ?? constant.darkGreen;
    constant.footerIconColor = footerIconColor ?? constant.lightGreen;
    constant.footerTextColor = footerTextColor ?? constant.lightGreen;
    constant.buttonBackgroundColor = buttonBackgroundColor ?? constant.lightGreen;
    constant.buttonShadowColor = buttonShadowColor ?? constant.lightGreenAccent;
    constant.buttonTextColor = buttonTextColor ?? constant.darkGreenAccent;
    constant.lineColor = lineColor ?? constant.lightGreen;
    constant.majorSectionTextColor = majorSectionTextColor ?? constant.lightGreenAccent;
    constant.minorSectionTextColor = minorSectionTextColor ?? constant.lightGreenAccent;
    // Text assignment
    constant.majorSectionText = majorSectionText ?? constant.majorSectionTextDefault;
    constant.pageOne = pageOneSubtitle ?? constant.pageOneDefault;
    constant.pageTwo = pageTwoSubtitle ?? constant.pageTwoDefault;
    constant.pageThree = pageThreeSubtitle ?? constant.pageThreeDefault;
    constant.pageFour = pageFourSubtitle ?? constant.pageFourDefault;
    constant.pageFive = pageFiveSubtitle ?? constant.pageFiveDefault;
    constant.pageSix = pageSixSubtitle ?? constant.pageSixDefault;
    constant.pageSeven = pageSevenSubtitle ?? constant.pageSevenDefault;
    // Settings
    return Scaffold(
      backgroundColor: constant.backgroundColor,
      body: Stack(
        children: [
          Consumer(builder: (context, ref, child) {
            ref.read(navigatorServices).setallowDirectNavigation(allowDirectNavigation ?? true);
            ref.read(navigatorServices).setPages(pages);
            return const PageViewAnimator();
          }),
          SafeArea(
            child: SizedBox(
              width: 43.0,
              height: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.topCenter,
                children: const [
                  Positioned(top: 15.0, child: Line()),
                  NumberButtonAnimation(buttonNumber: 1),
                  NumberButtonAnimation(buttonNumber: 2),
                  NumberButtonAnimation(buttonNumber: 3),
                  NumberButtonAnimation(buttonNumber: 4),
                  NumberButtonAnimation(buttonNumber: 5),
                  NumberButtonAnimation(buttonNumber: 6),
                  NumberButtonAnimation(buttonNumber: 7),
                  NavigatorTitleBoxAnimation(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
