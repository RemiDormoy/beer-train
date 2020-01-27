import 'package:beer_train/TrainRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class Passager extends StatefulWidget {
  String _name;
  String _image;
  DriverChosenCallback _onClick;

  Passager(this._name, this._image, [this._onClick]);

  @override
  _PassagerState createState() => _PassagerState();
}

class _PassagerState extends State<Passager> {
  @override
  Widget build(BuildContext context) {
    var opacity;
    var yolo;
    if (_isSelected()) {
      opacity = 0.6;
      yolo = Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11)
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Icon(Icons.check_circle, color: skyGradientTop, size: 20.0),
            ),
          ),
        ),
      );
    } else {
      opacity = 1.0;
      yolo = Container();
    }
    return GestureDetector(
      onTap: () {
        widget._onClick(_isSelected(), widget._name);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 4, color: Colors.black38)),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Opacity(
                      opacity: opacity,
                      child: Image.asset(widget._image),
                    ),
                  ),
                  yolo,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget._name),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSelected() {
    var train = TrainRepository.getInstance().getTrain();
    if (train != null) {
      return train.members.contains(widget._name);
    } else {
      return false;
    }
  }
}

typedef DriverChosenCallback = void Function(bool, String);
