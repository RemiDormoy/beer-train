import 'package:beer_train/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReloadModel(),
      child: Scaffold(
        body: MainPage(),
      ),
    );
  }
}

class ReloadModel extends ChangeNotifier {

  bool shouldReload = false;

  void reload() {
    shouldReload = true;
    notifyListeners();
  }
}
