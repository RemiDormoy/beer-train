import 'package:flutter/material.dart';

import 'colors.dart';

class TrainAvancement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.location_on, color: zeus, size: 40,),
            Expanded(
              flex: 4,
              child: Container(),
            ),
            Icon(Icons.location_on, color: coquelicot, size: 40,),
            Expanded(
              flex: 4,
              child: Container(),
            ),
            Icon(Icons.location_on, color: zeus, size: 40,),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: MySeparator(color: Colors.grey),
        ),
      ],
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 2, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
