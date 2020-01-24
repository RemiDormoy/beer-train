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
                padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                child: TrainAvancement(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[Text('18:00'), Text('LE K1ZE')],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
              Text(
                'IL EST EN ROUTE !',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
