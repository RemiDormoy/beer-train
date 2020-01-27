import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PassengersList.dart';

class GetOnBoardDialog extends StatefulWidget {
  @override
  _GetOnBoardDialogState createState() => _GetOnBoardDialogState();
}

class _GetOnBoardDialogState extends State<GetOnBoardDialog>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    var isModalModel = Provider.of<GetOnBoardModel>(context).getOpenitude();
    if (isModalModel) {
      print(isModalModel.toString() + "yolo ta race");
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: PassengersList(_passengerChosen),
      );
    } else {
      return Container();
    }
  }

  void _passengerChosen() {

  }
}

class GetOnBoardModel extends ChangeNotifier {
  bool _isOpen = false;

  bool getOpenitude() {
    print('je viens de getter : ${_isOpen.toString()}');
    return _isOpen;
  }

  void open() {
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
      print('je viens de notifier');
    }
  }

  void close() {
    if (_isOpen) {
      _isOpen = false;
      notifyListeners();
    }
  }
}