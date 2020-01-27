import 'package:beer_train/GetOnBoardButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TrainRepository.dart';
import 'colors.dart';
import 'home.dart';

// ignore: must_be_immutable
class TimeAndPlace extends StatefulWidget {
  TimeAndPlaceBack _callback;

  TimeAndPlace(this._callback);

  @override
  _TimeAndPlaceState createState() => _TimeAndPlaceState();
}

class _TimeAndPlaceState extends State<TimeAndPlace> {
  double _discreteValue = 18.0 * 60;

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A39),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: widget._callback,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                  "Lieu et heure d'arrivée",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                )),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 20, 0),
          child: Text(
            "Gare d'arrivée",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Le k1nze"),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Arrivée prévue :",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Text(
                      _calculeLHeure(_discreteValue.round()),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              ),
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
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
          child: GestureDetector(
            onTap: () {
              var place = _controller.text.length == 0 ? 'Le k1nze' : _controller.text;
              TrainRepository.getInstance().createTrain(_calculeLHeure(_discreteValue.round()), place);
              Provider.of<CreateTrainModalModel>(context, listen: false).close();
              Provider.of<ReloadModel>(context, listen: false).reload();
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
                color: skyGradientTop,
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
    return "${hours}h$minutes";
  }
}

typedef TimeAndPlaceBack = void Function();
