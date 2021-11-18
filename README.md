# sequential_navigator

    A vertical sequential sidebar navigation panel
    A way to sequentially control user flow through major and minor sections
    Sequential flow through menu or direct page index access
    This is a work in progress - please contribute if you can

# Demo

iOS | Android
:-: | :-:
<video src='https://user-images.githubusercontent.com/70868433/142352951-984c9e13-5f48-4611-85fe-010f2c8007e1.mov' width=180/> | <video src='https://user-images.githubusercontent.com/70868433/142352997-b101ed58-7075-440d-9c08-0de657ed623a.mov' width=180/>

# Contribution note

    There is a lot of work to be done with this package. If you're interested in helping, 
    please do!

    This is a note to potential contributors:
    This package was designed as a necessary piece of a larger project, I decided to make it a
    package because I wanted to give back to the flutter community.

    I am a very new developer, therefore I need A TON of help developing this package further. One look
    through this package and an experienced software engineer will probably see many areas of
    improvement. I am extremely busy with a full-time job as well, full-time after work current
    software project and more lack of time things, so any contribution is appreciated.

    I only have a few conditions for pull requests:
      1 - only add features and functionality never remove
      2 - only increase usability across platforms never reduce
      3 - if you change my code, please tell me what I did either, wrong, or how what you are
          changing is better (I want to learn how to improve, especially my architecture &
          resource management) - do this by comment in addition to documentation or by a new 
          readme file. Thank you.

# Example Use:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:squential_navigator/sequential_navigator/widgets/page_sliver.dart';
import 'package:squential_navigator/sequential_navigator/widgets/sequential_navigator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'sequential_navigator/services/navigator_services.dart';

Future<void> main() async {
  // Hive initializations
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await NavigatorServices().stateCheck();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageSliver pageSliver = PageSliver();
    return MaterialApp(
      home: SequentialNavigator(
        pages: [
          pageSliver.blue,
          pageSliver.red,
          pageSliver.green,
          pageSliver.indigo,
          pageSliver.pink,
          pageSliver.purple,
          pageSliver.yellow,
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Your content
class PageSliver {

  /*
    * This is an example builder for page content for this Sequential Navigator
    * [pageSliverBuilder()] is page content layout creator
  */

  /// Screen content example for demo
  SliverChildBuilderDelegate pageSliverBuilder(MaterialColor color) {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.all(15),
          child: Container(
            color: color[100 * (index % 9 + 1)],
            height: 80,
            alignment: Alignment.center,
            child: const Text(
              '',
              style: TextStyle(fontSize: 30),
            ),
          ),
        );
      },
      childCount: 10,
    );
  }

  SliverChildBuilderDelegate get red {
    return pageSliverBuilder(Colors.red);
  }

  SliverChildBuilderDelegate get blue {
    return pageSliverBuilder(Colors.blue);
  }

  SliverChildBuilderDelegate get green {
    return pageSliverBuilder(Colors.green);
  }

  SliverChildBuilderDelegate get yellow {
    return pageSliverBuilder(Colors.yellow);
  }

  SliverChildBuilderDelegate get purple {
    return pageSliverBuilder(Colors.purple);
  }

  SliverChildBuilderDelegate get indigo {
    return pageSliverBuilder(Colors.indigo);
  }

  SliverChildBuilderDelegate get pink {
    return pageSliverBuilder(Colors.pink);
  }
}

```

# Purpose:

    - To free up total vertical scroll viewing area
    - Many UIs include bottom navigation or top app bars, this navigation aims to:
      - Give as much vertical space as possible for viewing lots of data at once
      - To be combined with listViews and general scrolling
    - To have major and minor section separation of data and UI
    - *** Important note:
      - Technically this widget is simple a way of separating sections of UI
      - This may be ideal in many situations and others not so ideal
      - This widget is designed for very specific use, I hope it can be of assistance
  
# Fixes & TODOs

    - Fix state persistence issue
      - Currently the saved state is gotten and updated after the widget build
      - This causes an abrupt jump to the previously saved index on load
    - Fix consumer multi-rebuilding issue => FIXED

  - TODOs:
    - TODO: NON-MANUAL TESTING!
    - TODO: Refactor entire widget into reusable widget with text, page inputs, & colors
    - TODO: Refactor to include customization & features
    - TODO: Fix root directory spelling error
    - TODO: Index button tap callback - go to index directly (non-sequentially)
    - TODO: Dynamically size to any screen size
    - TODO: Create landscape version
    - TODO: Allow vertical or horizontal placement of menu
    - TODO: Allow for non-sliver pages with same scrolling animations
    - TODO: Allow for animation customization and different animations for menu and pages
    - FIX: State persistence issue- currently lost the location where reading saved state was working
    - FIX: Screen size issue- algorithm not correct for dynamic sizing to fit any screen size (smaller screens)
    - FIX: First page pull down to refresh - nothing should appear (currently "refresh complete")
    - FIX: Last page pull up to load - nothing should appear (currently "load complete")
    - DONE: Add "pull up to load next" gesture to each page
    - DONE: Add animation on pull to load

  - Solved issues:
    - Consumer rebuilding many widgets at once
      - Fixed using .select
      - Example: [ref.watch(navigatorServices.select((service) => service.buttonPosition(buttonNumber)))]
