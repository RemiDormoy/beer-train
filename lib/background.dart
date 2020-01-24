import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green
        ),
        child: SizedBox(
          height: 200,
          width: 200,
          child: LottieView.fromFile(
            onViewCreated: onViewCreatedFile,
            filePath: "assets/train.json",
            autoPlay: true,
            loop: true,
            reverse: false,
          ),
        ),
      ),
    );
  }

  void onViewCreatedFile(LottieController controller) {
    _newProgressStream.stream.listen((double progress) {
      _controller.setAnimationProgress(progress);
    });
  }
}
