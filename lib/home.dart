import 'package:beer_train/GetOnBoardButton.dart';
import 'package:beer_train/background.dart';
import 'package:beer_train/trainAvancement.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                'Il est en route !\n3 passagers sont à bord',
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
        ],
      ),
    );
  }
}
