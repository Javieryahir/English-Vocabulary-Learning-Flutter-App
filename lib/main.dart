import 'package:dictionaryenglish/pages/learnPage.dart';
import 'package:dictionaryenglish/pages/listWordPage.dart';
import 'package:dictionaryenglish/pages/searchPage.dart';
import 'package:dictionaryenglish/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UnityAds.init(
    gameId: "5526719",
    testMode: false,
    onComplete: () {
      print('Initialization Complete');
    },
    onFailed: (error, message) =>
        print('Initialization Failed: $error $message'),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "bottomNav",
      routes: {
        "learnPage": (BuildContext context) => learnPage(),
        "listWordPage": (BuildContext context) => listWordPage(),
        "searchPage": (BuildContext context) => searchPage(),
        "bottomNav": (BuildContext context) => bottomNavigationBar()
      },
    );
  }
}
