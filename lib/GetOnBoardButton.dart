import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GetOnBoardDialog.dart';
import 'TrainRepository.dart';
import 'colors.dart';

class GetOnBoardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var modalModel = Provider.of<CreateTrainModalModel>(context);
    var modal2Model = Provider.of<GetOnBoardModel>(context);
    var textMan;
    if (TrainRepository.getInstance().getTrain() != null) {
      textMan = 'Je monte à bord';
    } else {
      textMan = 'Lancer le train de la bière';
    }
    return GestureDetector(
      onTap: () {
        if (TrainRepository.getInstance().getTrain() != null) {
          print('je devrais monter à bord');
          modal2Model.open();
        } else {
          modalModel.open();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Center(
            child: Text(
              textMan,
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
