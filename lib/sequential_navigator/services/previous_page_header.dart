import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;

class PreviousPageHeader extends Header {
  final Key? key;
  final Color? color;
  final Color? backgroundColor;
  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  PreviousPageHeader({
    this.key,
    this.color = Colors.blue,
    this.backgroundColor = Colors.transparent,
    bool enableHapticFeedback = true,
    bool enableInfiniteRefresh = false,
  }) : super(
          extent: 70.0,
          triggerDistance: 70.0,
          float: false,
          enableHapticFeedback: enableHapticFeedback,
          enableInfiniteRefresh: enableInfiniteRefresh,
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    // 不能为水平方向
    assert(
        axisDirection == AxisDirection.down ||
            axisDirection == AxisDirection.up,
        'Widget cannot be horizontal');
    linkNotifier.contentBuilder(
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return PreviousPageHeaderWidget(
      key: key,
      color: color,
      backgroundColor: backgroundColor,
      linkNotifier: linkNotifier,
    );
  }
}

class PreviousPageHeaderWidget extends StatefulWidget {
  final Color? color;
  final Color? backgroundColor;
  final LinkHeaderNotifier linkNotifier;
  const PreviousPageHeaderWidget({
    Key? key,
    this.color,
    this.backgroundColor,
    required this.linkNotifier,
  }) : super(key: key);

  @override
  PreviousPageHeaderWidgetState createState() {
    return PreviousPageHeaderWidgetState();
  }
}

class PreviousPageHeaderWidgetState extends State<PreviousPageHeaderWidget> {
  double get _indicatorExtent => widget.linkNotifier.refreshIndicatorExtent;

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
            color: constant.headerBackgroundColor,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'PULL DOWN',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: constant.headerTextColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_circle_down_rounded,
                          color: constant.headerIconColor,
                          size: 40.0,
                        ),
                        Text(
                          'PREVIOUS PAGE',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: constant.headerTextColor,
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