import 'dart:async';
import 'dart:math';
import 'package:beer_train/TrainRepository.dart';
import 'package:beer_train/colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundBeerTrain extends StatefulWidget {
  @override
  _BackgroundBeerTrainState createState() => _BackgroundBeerTrainState();
}

class _BackgroundBeerTrainState extends State<BackgroundBeerTrain> {
  @override
  Widget build(BuildContext context) {
    var height = min(MediaQuery.of(context).size.width * 667 / 375,
        MediaQuery.of(context).size.height - 5);
    var poweredLogo;
    if (MediaQuery.of(context).size.width < 300 &&
        MediaQuery.of(context).size.height < 300) {
      poweredLogo = Container();
    } else {
      poweredLogo = Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Powered by',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              buildSvgPicture(),
            ],
          ),
        ),
      );
    }
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [skyGradientTop, skyGradientBottom]),
                ),
              ),
            ),
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: backgroundSeparatorGreen,
              ),
            ),
            Container(
              height: height * 370 / 667,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [grassGradientTop, grassGradientBottom]),
              ),
            ),
          ],
        ),
        poweredLogo,
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width,
              child: LottieStuff(),
              decoration: BoxDecoration(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSvgPicture() {
    if (kIsWeb) {
      return Image.asset(
        "assets/doggy_name.png",
        height: 80,
        width: 80,
      );
    }
    return SvgPicture.asset(
      'assets/logo_doggy_text.svg',
      color: Colors.white,
    );
  }
}

class LottieStuff extends StatefulWidget {
  @override
  _LottieStuffState createState() => _LottieStuffState();
}

class _LottieStuffState extends State<LottieStuff> {
  String _asset = "assets/only_driver_train.flr";

  @override
  Widget build(BuildContext context) {
    var train = TrainRepository.getInstance().getTrain();
    var asset;
    if (train == null) {
      asset = "assets/no_train.flr";
    } else if (train.members.length <= 1) {
      asset = "assets/only_driver_train.flr";
    } else if (train.members.length <= 4) {
      asset = "assets/train_1_wagon.flr";
    } else if (train.members.length <= 7) {
      print('le train a 2 wagon');
      asset = "assets/train_2_wagons.flr";
    } else {
      asset = "assets/train_3_wagons.flr";
    }
    if (asset != _asset) {
      _asset = asset;
      Timer(Duration(milliseconds: 100), () {
        setState(() {});
      });
      return Text('');
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: FlareActor(
          asset,
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          animation: "Animations",
          callback: (name) {
            if (name == "Animations") {
              setState(() {
                _asset = "";
              });
            }
          },
        ),
      ),
    );
  }
}
