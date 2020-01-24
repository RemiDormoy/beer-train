import 'package:beer_train/passager.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

// ignore: must_be_immutable
class TimeAndPlace extends StatefulWidget {
  DriverChosenCallback _callback = () {};

  TimeAndPlace([this._callback]);

  @override
  _TimeAndPlaceState createState() => _TimeAndPlaceState();
}

class _TimeAndPlaceState extends State<TimeAndPlace> {
  double _discreteValue = 18.0 * 60;

  String _eta = "18:00";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: widget._callback,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 30, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 60,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 50, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Text(
            "LIEU ET HEURE D'ARRIVÉE",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Lieu d'arrivée"),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Column(
            children: <Widget>[
              Slider(
                value: _discreteValue,
                min: (17 * 60).toDouble(),
                max: (20.5 * 60).toDouble(),
                divisions: 14,
                onChanged: (value) {
                  setState(() {
                    _discreteValue = value;
                  });
                },
                label: _calculeLHeure(_discreteValue.round()),
              ),
              Text("ARRIVÉE PRÉVUE À : $_eta")
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 80,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Center(
                  child: Text(
                    "C'EST PARTI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: coquelicot,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        )
      ],
    );
  }

  String _calculeLHeure(int value) {
    String hours = (value / 60).truncate().toString();
    String minutes = (value % 60).round().toString();
    if (minutes.length == 1) {
      minutes = minutes + "0";
    }
    _eta = "${hours}h$minutes";
    return _eta;
  }
}
