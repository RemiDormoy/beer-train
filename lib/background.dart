import 'dart:async';
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
  LottieController _controller;
  StreamController<double> _newProgressStream;

  @override
  void initState() {
    super.initState();
    _newProgressStream = StreamController<double>();
  }

  void dispose() {
    super.dispose();
    _newProgressStream.close();
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [grassGradientTop, grassGradientBottom]),
                ),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 118, 0, 0),
          child: Container(
            height: MediaQuery.of(context).size.width * 667 / 375,
            width: MediaQuery.of(context).size.width,
            child: buildLottieView(),
          ),
        ),
      ],
    );
  }

  Widget buildLottieView() {
    if (TrainRepository.getInstance().getTrain() != null) {
      return LottieView.fromFile(
        onViewCreated: onViewCreatedFile,
        filePath: "assets/train_3_wagons.json",
        autoPlay: true,
        loop: true,
        reverse: false,
      );
    } else {
      return Text('');
    }
  }

  void onViewCreatedFile(LottieController controller) {
    _newProgressStream.stream.listen((double progress) {
      _controller.setAnimationProgress(progress);
    });
  }
}
