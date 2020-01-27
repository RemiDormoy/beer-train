import 'package:beer_train/TrainRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PassengersList.dart';
import 'colors.dart';
import 'home.dart';

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
      return Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: PassengersList((bool isSelected, String name) {
                TrainRepository.getInstance().addOrRemoveMember(isSelected, name);
                Provider.of<GetOnBoardModel>(context, listen: false).close();
                Provider.of<ReloadModel>(context, listen: false).reload();
              }),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, (MediaQuery.of(context).size.height * 0.85) - 30, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Provider.of<GetOnBoardModel>(context, listen: false).close();
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
      );
    } else {
      return Container();
    }
  }

}

class GetOnBoardModel extends ChangeNotifier {
  bool _isOpen = false;

  bool getOpenitude() {
    print('je viens de getter : ${_isOpen.toString()}');
    return _isOpen;
  }

  void open() {
    print('je suis la wesh');
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
