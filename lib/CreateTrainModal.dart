import 'package:beer_train/TrainRepository.dart';
import 'package:beer_train/colors.dart';
import 'package:flutter/material.dart';
import 'package:beer_train/timeAndPlace.dart';
import 'package:provider/provider.dart';

import 'GetOnBoardButton.dart';
import 'drivers.dart';

class CreateTrainModal extends StatefulWidget {
  @override
  _CreateTrainModalgState createState() => _CreateTrainModalgState();
}

class _CreateTrainModalgState extends State<CreateTrainModal>
    with TickerProviderStateMixin {
  static Matrix4 _pmat(num pv) {
    return new Matrix4(
      1.0,
      0.00,
      0.00,
      0.00,
      //
      0.00,
      1.0,
      0.001,
      0.00,
      //
      0.00,
      0.00,
      1.0,
      0.001,
      //
      0.00,
      0.00,
      0.00,
      1.0,
    );
  }

  Matrix4 perspective = _pmat(1.0);

  Animation<double> _degrees;

  bool _isOnList = true;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Provider.of<CreateTrainModalModel>(context),
      child: yolo(context),
    );
  }

  Widget yolo(BuildContext context) {
    var isModalModel =
        Provider.of<CreateTrainModalModel>(context).getOpenitude();
    if (isModalModel) {
      return Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: _buildContainer,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildContainer(BuildContext context, Widget child) {
    var card;
    if (_isOnList) {
      card = DriverList(_onDriverChoosen);
    } else {
      card = Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, -0.001)
          ..rotateY(180 * 3.14 / 180)
          ..rotateX(0.0)
          ..rotateZ(0.0),
        child: TimeAndPlace(_onBack),
      );
    }
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY((_degrees != null ? _degrees.value : 0) * 3.14 / 180)
        ..rotateX(0.0)
        ..rotateZ(0.0),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 8.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ]),
              child: card,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, (MediaQuery.of(context).size.height * 0.85) - 30, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Provider.of<CreateTrainModalModel>(context, listen: false).close();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: coquelicot,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 8.0,
                          offset: Offset(2.0, 2.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(30)),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onBack() {
    _controller.reverse();
  }

  void _onDriverChoosen(bool isSelected, String name) {
    TrainRepository.getInstance().setSelectedChief(name);
    setState(() {
      _degrees = Tween<double>(
        begin: 0.0,
        end: 180.0,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.0,
            1.0,
            curve: Curves.easeIn,
          ),
        ),
      )..addListener(() {
          if (_degrees.value >= 90 && _isOnList) {
            _isOnList = false;
          } else if (_degrees.value < 90 && !_isOnList) {
            _isOnList = true;
          }
        });
      _controller.forward();
    });
  }
}
