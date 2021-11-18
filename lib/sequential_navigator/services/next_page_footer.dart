import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;

class NextPageFooter extends Footer {
  final Key? key;
  final Color? color;
  final Color? backgroundColor;
  final LinkFooterNotifier linkNotifier = LinkFooterNotifier();

  NextPageFooter({
    this.key,
    this.color = Colors.blue,
    this.backgroundColor = Colors.transparent,
    bool enableHapticFeedback = true,
    bool enableInfiniteLoad = false,
    bool overScroll = true,
  }) : super(
          extent: 70.0,
          triggerDistance: 70.0,
          float: false,
          enableHapticFeedback: enableHapticFeedback,
          enableInfiniteLoad: enableInfiniteLoad,
          overScroll: overScroll,
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    assert(axisDirection == AxisDirection.down || axisDirection == AxisDirection.up,
        'Widget cannot be horizontal');
    linkNotifier.contentBuilder(context, loadState, pulledExtent, loadTriggerPullDistance,
        loadIndicatorExtent, axisDirection, float, completeDuration, enableInfiniteLoad, success, noMore);
    return NextPageFooterWidget(
      key: key,
      color: color,
      backgroundColor: backgroundColor,
      linkNotifier: linkNotifier,
    );
  }
}

class NextPageFooterWidget extends StatefulWidget {
  final Color? color;
  final Color? backgroundColor;
  final LinkFooterNotifier linkNotifier;
  const NextPageFooterWidget({
    Key? key,
    this.color,
    this.backgroundColor,
    required this.linkNotifier,
  }) : super(key: key);

  @override
  NextPageFooterWidgetState createState() {
    return NextPageFooterWidgetState();
  }
}

class NextPageFooterWidgetState extends State<NextPageFooterWidget> {
  double get _indicatorExtent => widget.linkNotifier.loadIndicatorExtent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            alignment: Alignment.center,
            height: _indicatorExtent,
            color: constant.footerBackgroundColor,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'PULL UP',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: constant.footerTextColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_circle_up_rounded,
                          color: constant.footerIconColor,
                          size: 40.0,
                        ),
                        Text(
                          'NEXT PAGE',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: constant.footerTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
