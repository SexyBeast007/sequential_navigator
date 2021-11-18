import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sequential_navigator/sequential_navigator/services/navigator_services.dart';
import 'package:sequential_navigator/sequential_navigator/services/next_page_footer.dart';
import 'package:sequential_navigator/sequential_navigator/services/previous_page_header.dart';

class SequentialPage extends StatelessWidget {
  final SliverChildBuilderDelegate pageContents;
  const SequentialPage({Key? key, required this.pageContents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          const SizedBox(width: 40.0),
          Consumer(builder: (context, ref, child) {
            final int pageIndex = ref.read(navigatorServices).pageIndex;
            final int indexCount = ref.read(navigatorServices).indexCount;
            return Expanded(
              child: EasyRefresh.custom(
                header: (pageIndex != 1) ? PreviousPageHeader() : null,
                footer: (pageIndex != indexCount) ? NextPageFooter() : null,
                onRefresh: () async => (pageIndex != 1) ? ref.read(navigatorServices).previousPage() : null,
                onLoad: () async => (pageIndex != indexCount) ? ref.read(navigatorServices).nextPage() : null,
                slivers: [
                  SliverList(delegate: pageContents),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
