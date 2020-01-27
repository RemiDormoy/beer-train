import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class TrainAvancement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 12.0,
            offset: Offset(2.0, 2.0),
          ),
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.my_location),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Le k1nze'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.access_time),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Text('19h15'),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 1,
              height: 40,
              decoration: BoxDecoration(color: Colors.grey),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(),
                      ),
                      Icon(
                        Icons.location_on,
                        color: coquelicot,
                        size: 30,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(),
                      ),
                      Icon(
                        Icons.location_on,
                        color: zeus,
                        size: 30,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: MySeparator(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
