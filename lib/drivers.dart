import 'package:beer_train/passager.dart';
import 'package:flutter/material.dart';

class DriverList extends StatelessWidget {
  DriverChosenCallback _onDriverChoosen;

  DriverList(this._onDriverChoosen);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Text(
                  'Choix du chef de bord',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
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
