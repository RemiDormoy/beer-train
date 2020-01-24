import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Passager extends StatefulWidget {
  String _name;
  String _image;
  DriverChosenCallback _onClick;

  Passager(this._name, this._image, [this._onClick]);

  @override
  _PassagerState createState() => _PassagerState();
}

class _PassagerState extends State<Passager> {

  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    double borderSize;
    if (_selected) {
      borderSize = 10;
    } else {
      borderSize = 4;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
        widget._onClick();
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
                  border: Border.all(width: borderSize, color: Colors.black38)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(widget._image),
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
}

typedef DriverChosenCallback = void Function();

