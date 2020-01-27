import 'package:beer_train/trainAvancement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CreateTrainModal.dart';
import 'GetOnBoardButton.dart';
import 'GetOnBoardDialog.dart';
import 'TrainRepository.dart';
import 'background.dart';
import 'colors.dart';
import 'home.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLoaded = false;


  @override
  void initState() {
    super.initState();
    TrainRepository.getInstance().init().then((_) {
      setState(() {
        _isLoaded = true;
      });
    }).catchError((_) {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ReloadModel>(context).shouldReload) {
      TrainRepository.getInstance().init().then((_) {
        setState(() {
          _isLoaded = true;
        });
      }).catchError((_) {
        setState(() {
          _isLoaded = true;
        });
      });
    }
    var body;
    if (_isLoaded) {
      body = buildLoadedHome();
    } else {
      body = Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(coquelicot), strokeWidth: 5.0),
      );
    }
    return body;
  }

  ChangeNotifierProvider<GetOnBoardModel> buildLoadedHome() {
    var textMan;
    if (TrainRepository.getInstance().getTrain() != null) {
      var yolo = TrainRepository.getInstance().getTrain().members.length.toString();
      textMan = 'Il est en route !\n$yolo passagers sont à bord';
    } else {
      textMan = 'Aucun train en route';
    }

    return ChangeNotifierProvider(
      create: (_) => GetOnBoardModel(),
      child: ChangeNotifierProvider(
        create: (_) => CreateTrainModalModel(),
        child: Stack(
          children: <Widget>[
            BackgroundBeerTrain(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
                  child: TrainAvancement(),
                ),
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                Text(
                  textMan,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                GetOnBoardButton(),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
            CreateTrainModal(),
            GetOnBoardDialog(),
          ],
        ),
      ),
    );
  }
}
