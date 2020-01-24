import 'package:beer_train/passager.dart';
import 'package:flutter/material.dart';

class DriverList extends StatelessWidget{


  DriverChosenCallback _onDriverChoosen;

  DriverList(this._onDriverChoosen);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 60,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Text(
            'CHOIX DU CHEF DE BORD',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                Passager('BEJ', "assets/bej.jpg", _onDriverChoosen),
                Passager('MBI', "assets/marie.jpg", _onDriverChoosen),
                Passager('DAS', "assets/danyboy.jpg", _onDriverChoosen),
                Passager('JDO', "assets/juliette.jpg", _onDriverChoosen),
                Passager('CYG', "assets/cyril.jpg", _onDriverChoosen),
                Passager('LAAL', "assets/alizee.jpg", _onDriverChoosen),
                Passager('BME', "assets/bme.jpg", _onDriverChoosen),
                Passager('BRM', "assets/brm.jpg", _onDriverChoosen),
                Passager('RDO', "assets/remi.jpg", _onDriverChoosen),
                Passager('BEJ', "assets/megane.jpg", _onDriverChoosen),
                Passager('RBO', "assets/rafaelle.jpg", _onDriverChoosen),
              ],
            ),
          ),
        )
      ],
    );
  }
}