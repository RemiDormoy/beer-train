import 'dart:async';
import 'dart:math';
import 'package:beer_train/TrainRepository.dart';
import 'package:beer_train/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundBeerTrain extends StatefulWidget {
  @override
  _BackgroundBeerTrainState createState() => _BackgroundBeerTrainState();
}

class _BackgroundBeerTrainState extends State<BackgroundBeerTrain> {
  @override
  Widget build(BuildContext context) {
    var rationCiel = 297 / 667;
    var height = MediaQuery.of(context).size.width * 667 / 375;
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
        Align(
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
                SvgPicture.asset(
                  'assets/logo_doggy_text.svg',
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                10),
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width,
              child: LottieStuff(),
              decoration: BoxDecoration(
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LottieStuff extends StatefulWidget {
  @override
  _LottieStuffState createState() => _LottieStuffState();
}

class _LottieStuffState extends State<LottieStuff> {
  LottieController _controller;
  StreamController<double> _newProgressStream;
  String _asset = "assets/no_train.json";

  @override
  Widget build(BuildContext context) {
    var train = TrainRepository.getInstance().getTrain();
    var asset;
    if (train == null) {
      asset = "assets/no_train.json";
    } else if (train.members.length <= 1) {
      asset = "assets/only_driver_train.json";
    } else if (train.members.length <= 4) {
      asset = "assets/train_1_wagon.json";
    } else if (train.members.length <= 7) {
      print('le train a 2 wagon');
      asset = "assets/train_2_wagons.json";
    } else {
      asset = "assets/train_3_wagons.json";
    }
    if (asset != _asset) {
      _asset = asset;
      Timer(Duration(milliseconds: 300), () {
        setState(() {});
      });
      return Text('');
    }
    return LottieView.fromFile(
      onViewCreated: onViewCreatedFile,
      filePath: _asset,
      autoPlay: true,
      loop: true,
      reverse: false,
    );
  }

  @override
  void initState() {
    super.initState();
    _newProgressStream = StreamController<double>();
  }

  void dispose() {
    super.dispose();
    _newProgressStream.close();
  }

  void onViewCreatedFile(LottieController controller) {
    _newProgressStream.stream.listen((double progress) {
      _controller.setAnimationProgress(progress);
    });
  }
}
