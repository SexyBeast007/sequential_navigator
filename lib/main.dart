import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/page_sliver.dart';
import 'package:sequential_navigator/sequential_navigator/widgets/sequential_navigator.dart';
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
