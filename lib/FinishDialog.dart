import 'package:beer_train/TrainRepository.dart';
import 'package:beer_train/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FinishDialog extends StatefulWidget {
  @override
  _FinishDialogState createState() => _FinishDialogState();
}

class _FinishDialogState extends State<FinishDialog> {
  bool _wasShown = false;

  @override
  Widget build(BuildContext context) {
    var train = TrainRepository.getInstance().getTrain();
    var dateTime = DateTime.now();
    if (!_wasShown && train != null && train.end.isBefore(dateTime)) {
      return Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 8.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 60, 30, 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Le train vient d'entrer en gare",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: buildSvgPicture(),
                      ),
                      Text(
                          "Éloigne toi de la bordure du quai et viens boire une pinte",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))
                    ],
                  ),
                ),
              ),
            ),
          ),
          buildBandeau(context, train),
          buildButton(context),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget buildSvgPicture() {
    if (kIsWeb) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 3,
          maxHeight: MediaQuery.of(context).size.height / 6,
        ),
        child: Image.asset("assets/bonheur_beers.png"),
      );
    }
    return SvgPicture.asset("assets/bonheur_beers.svg");
  }

  Align buildButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _wasShown = true;
          });
        },
        child: Container(
            margin: EdgeInsets.only(
                bottom: (MediaQuery.of(context).size.height * 0.25) - 85),
            decoration: BoxDecoration(
                color: skyGradientTop,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 8.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            )),
      ),
    );
  }

  Padding buildBandeau(BuildContext context, Train train) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          15, (MediaQuery.of(context).size.height * 0.25) - 70, 15, 0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Center(
              child: buildSvgBandeau(context),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.045),
              child: Center(
                  child: Text(
                train.arrivalPlace,
                style: TextStyle(
                    color: Color(0xFFf7931e),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSvgBandeau(BuildContext context) {
    if (kIsWeb) {
      return Image.asset("assets/congrats_bandeau.png");
    }
    return SvgPicture.asset(
      "assets/congrats_bandeau.svg",
      width: MediaQuery.of(context).size.width - 20,
    );
  }
}
