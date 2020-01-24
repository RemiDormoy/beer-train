import 'package:beer_train/passager.dart';
import 'package:beer_train/timeAndPlace.dart';
import 'package:flutter/material.dart';

import 'drivers.dart';

class GetOnBoardDialog extends StatefulWidget {
  @override
  _GetOnBoardDialogState createState() => _GetOnBoardDialogState();
}

class _GetOnBoardDialogState extends State<GetOnBoardDialog>
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: _buildContainer,
        ),
      ),
    );
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
          ..rotateY(180  * 3.14 / 180)
          ..rotateX(0.0)
          ..rotateZ(0.0),
        child: TimeAndPlace(),
      );
    }
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY((_degrees != null ? _degrees.value : 0) * 3.14 / 180)
        ..rotateX(0.0)
        ..rotateZ(0.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: card,
      ),
    );
  }

  void _onDriverChoosen() {
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
          }
        });
      _controller.forward();
    });
  }
}
