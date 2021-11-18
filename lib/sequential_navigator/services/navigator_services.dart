import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sequential_navigator/sequential_navigator/constants/ui_constants.dart' as constant;
import 'package:sequential_navigator/sequential_navigator/database/state_crud.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/sequential_page.dart';

final navigatorServices = ChangeNotifierProvider((ref) => NavigatorServices());

class NavigatorServices extends ChangeNotifier {
  StateCRUD stateCRUD = StateCRUD();
  PageController pageController = PageController();
  int pageIndex = 1;
  int indexCount = 7;
  List<int> pageIndexLog = [];
  List<Widget> pages = [];
  List<Widget> buttons = [];
  List<Widget> sequentialNavigatorChildren = [];
  bool allowDirectNavigation = true;

  /// Handles next page logic
  /// Causes scrolling page controller to animate to next page
  void nextPage() {
    if (pageIndex < indexCount) {
      pageIndex++;
      pageController.animateToPage(
        pageIndex - 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.bounceOut,
      );
      saveState();
      notifyListeners();
    }
  }

  /// Handles previous page logic
  /// Causes scrolling page controller to animate to previous page
  void previousPage() {
    if (pageIndex > 1) {
      pageIndex--;
      pageController.animateToPage(
        pageIndex - 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.bounceOut,
      );
      saveState();
      notifyListeners();
    }
  }

  /// Navigates directly to page index
  /// Skips pages based on users choice of direct navigation
  void navigateToPage(int index) {
    pageIndex = index;
    pageController.animateToPage(
      pageIndex - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.bounceOut,
    );
    saveState();
    notifyListeners();
  }

  /// Gets last index for page transition animation
  /// Index.first = previousPage Index.last = currentPage
  List<int>? getPreviousPageIndex() {
    pageIndexLog.add(pageIndex);
    if (pageIndexLog.length > 1) {
      List<int> pageMovement = [pageIndexLog.reversed.elementAt(1), pageIndexLog.last];
      return pageMovement;
    }
  }

  /// Checks persistant storage for saved value
  /// Loads saved value to page state if it exists
  Future<void> stateCheck() async {
    int? storedPageIndex = await stateCRUD.readPageStateIndex();
    if (storedPageIndex != null && storedPageIndex != 1) {
      pageIndex = (await stateCRUD.readPageStateIndex())!;
      notifyListeners();
    }
  }

  /// Checks persistant storage for saved value
  /// Overwrites if it exists and creates it if it does not
  Future<void> saveState() async {
    (await stateCRUD.readPageStateIndex() == null)
        ? await stateCRUD.createPageStateIndex(pageIndex)
        : await stateCRUD.updatePageStateIndex(pageIndex);
  }

  /// Delete nevigator state
  /// Resets page index for return to navigator at default start index
  Future<void> deleteState() async {
    await stateCRUD.deletePageStateIndex();
  }

  /// Gives each individual button position dynamically based on their index
  double buttonPosition(int buttonNumber) {
    double totalHeight = Get.height;
    double topPadding = WidgetsBinding.instance!.window.padding.top;
    double bottomPadding = WidgetsBinding.instance!.window.padding.bottom;
    double safeArea = totalHeight - (topPadding + bottomPadding);
    const double buttonWithPadding = 35.0;
    late double buttonTop;
    List<int> pageIndexes = [];
    int index = 0;
    // Current or past screen
    if (pageIndex >= buttonNumber) buttonTop = ((buttonWithPadding * buttonNumber) - buttonWithPadding);
    if (pageIndex < buttonNumber) {
      while (index < indexCount + 1) {
        pageIndexes.add(index);
        index++;
      }
      buttonTop = (buttonWithPadding * pageIndexes[buttonNumber]) + safeArea / 1.5;
    }
    return buttonTop;
  }

  /// Dynamically creates line length based on lowest button
  /// Lowest button is based on page index length
  double lineHeight() {
    stateCheck();
    double totalHeight = Get.height;
    double topPadding = WidgetsBinding.instance!.window.padding.top;
    double bottomPadding = WidgetsBinding.instance!.window.padding.bottom;
    double safeArea = totalHeight - (topPadding + bottomPadding);
    const double buttonWithPadding = 35.0;
    double lowestButton = buttonWithPadding * indexCount;
    return lowestButton + (safeArea / 1.5);
  }

  /// Not used with current setup
  /// Do not delete in case of future need
  ///
  /// If previous button [true] else next button [false]
  double controlButtonPosition(bool previousButton) {
    double totalHeight = Get.height;
    double topPadding = WidgetsBinding.instance!.window.padding.top;
    double bottomPadding = WidgetsBinding.instance!.window.padding.bottom;
    double safeArea = totalHeight - (topPadding + bottomPadding);
    const double buttonWithPadding = 35.0;
    double buttonPosition;
    if (previousButton) {
      buttonPosition = (buttonWithPadding * indexCount) + (safeArea / 1.3);
    } else {
      buttonPosition = (buttonWithPadding * indexCount) + (safeArea / 1.2);
    }
    return buttonPosition;
  }

  /// Positions subtitle text precisely to right of line
  String navigatorSubtitleText() {
    List<String> subtitles = [
      constant.pageOne,
      constant.pageTwo,
      constant.pageThree,
      constant.pageFour,
      constant.pageFive,
      constant.pageSix,
      constant.pageSeven,
    ];
    List<int> pageIndexes = [];
    int index = 1;
    late String subtitle;
    while (index < indexCount + 1) {
      pageIndexes.add(index);
      index++;
    }
    for (int i = 0; i < indexCount + 1; i++) {
      if (pageIndex == i) {
        subtitle = subtitles[i - 1];
      }
    }
    return subtitle;
  }

  /// Positions major section title to left of line
  double navigatorTitleBoxPosition() {
    const double buttonWithPadding = 35.0;
    late double subtitleTop;
    const topPadding = 20.0;
    // Subtitle position
    subtitleTop = (buttonWithPadding * pageIndex) + topPadding;
    return subtitleTop;
  }

  /// Sets list of pages
  /// Builds layouts by page contents in the form of [SliverChildBuilderDelegate]
  void setPages(List<SliverChildBuilderDelegate> inputPages) {
    for (SliverChildBuilderDelegate page in inputPages) {
      pages.add(SequentialPage(pageContents: page));
    }
  }

  /// Set whether user can tap buttons to go directly to index
  void setallowDirectNavigation(bool parameter) {
    allowDirectNavigation = parameter;
  }

  /// Not used with current setup
  /// Do not delete in case of future need
  /// If needed in the future add argument for List<Widget>
  // Widget pageNavigator(List<Widget> userPages) {
  //   List<Widget> pages = userPages;
  //   List<int> pageIndexes = [];
  //   int index = 1;
  //   late Widget page;
  //   while (index < indexCount + 1) {
  //     pageIndexes.add(index);
  //     index++;
  //   }
  //   for (int i = 0; i < indexCount + 1; i++) {
  //     if (pageIndex == i) {
  //       page = pages[i - 1];
  //     }
  //   }
  //   return page;
  // }
}
