import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

class GetOnBoardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var modalModel = Provider.of<CreateTrainModalModel>(context);
    return GestureDetector(
      onTap: () {
        print('je click ok ?');
        modalModel.open();
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Center(
            child: Text(
              'Je monte à bord',
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
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 8.0,
                offset: Offset(2.0, 2.0),
              ),
            ]),
      ),
    );
  }
}

class CreateTrainModalModel extends ChangeNotifier {
  bool _isOpen = false;

  bool getOpenitude() {
    return _isOpen;
  }

  void open() {
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
    }
  }

  void close() {
    if (_isOpen) {
      _isOpen = false;
      notifyListeners();
    }
  }
}
